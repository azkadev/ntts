
cmake_minimum_required(VERSION 3.16)

include(CheckIncludeFileCXX)

project(ntts_library VERSION 0.0.0 LANGUAGES C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
message(STATUS "START COMPILE ntts")

find_package(PkgConfig)
pkg_check_modules(SPDLOG REQUIRED spdlog)

file(READ "${CMAKE_CURRENT_LIST_DIR}/VERSION" ntts_library_version)
  

string(APPEND CMAKE_CXX_FLAGS " -Wall -fPIC -Wextra -Wl,-rpath,'$ORIGIN'")
string(APPEND CMAKE_C_FLAGS " -Wall -fPIC -Wextra")



set(PIPER_PHONEMIZE_ROOTDIR ${CMAKE_CURRENT_LIST_DIR}/../../lib/${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}/piper_phonemize)



set(ntts_shared_dir "lib")
set(ntts_exe_dir "bin")
set(prefix_shared_library "lib")
 

if (ANDROID)
 set(package_shared_extension "_${ANDROID_ARCH_NAME}.so")
 set(package_exe_extension "")
 set(package_name "ntts_${ANDROID_ARCH_NAME}")
elseif (WIN32)
 set(package_shared_extension ".dll")
 set(package_exe_extension ".exe") 
 set(package_name "ntts")
elseif (APPLE)
 set(package_shared_extension ".dylib")
 set(package_exe_extension "") 
 set(package_name "ntts")
else()
 set(package_shared_extension ".so")
 set(package_exe_extension "") 
 set(package_name "ntts")
endif()

# add_library(ntts_shared SHARED main.cpp piper.cpp)
add_library(ntts_shared SHARED main.cpp piper.cpp)


# ADD_EXECUTABLE(ntts_shared main.cpp piper.cpp)
set_target_properties(ntts_shared PROPERTIES
  LIBRARY_OUTPUT_DIRECTORY "${ntts_shared_dir}"
  PREFIX "${prefix_shared_library}"
  OUTPUT_NAME "${package_name}"
)

message(STATUS "START COMPILE ${SPDLOG_LIBRARIES}")

# target_link_libraries(ntts_shared PRIVATE spdlog)
# target_compile_options(ntts_shared PRIVATE -fPIC)

target_link_libraries(ntts_shared 
                      piper_phonemize
                      espeak-ng
                      onnxruntime
                      pthread
                      # -static-libgcc -static-libstdc++
                      # spdlog

)

if(NOT APPLE)
  target_link_libraries(ntts_shared -static-libgcc -static-libstdc++)
endif()

target_link_directories(ntts_shared PUBLIC
                        ${PIPER_PHONEMIZE_ROOTDIR}/lib)

target_include_directories(ntts_shared PUBLIC
                           ${PIPER_PHONEMIZE_ROOTDIR}/include
                          #  ${SPDLOG_INCLUDE_DIRS}
                           )

# target_compile_options(ntts_shared PUBLIC
                      #  ${SPDLOG_CFLAGS_OTHER} -fPIC)

target_compile_definitions(ntts_shared PUBLIC _PIPER_VERSION=${ntts_library_version})

add_custom_command(
  TARGET ntts_shared POST_BUILD 
  COMMAND ${CMAKE_STRIP} --strip-debug --strip-unneeded "${ntts_shared_dir}/${prefix_shared_library}ntts${package_shared_extension}"
)
