cmake_minimum_required(VERSION 3.16)

include(CheckIncludeFileCXX)

project(ntts_library VERSION 0.0.1 LANGUAGES C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
message(STATUS "START COMPILE ntts")

string(APPEND CMAKE_CXX_FLAGS " -Wall -Wextra -Wl,-rpath,'$ORIGIN'")
string(APPEND CMAKE_C_FLAGS " -Wall -Wextra")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")

message(STATUS "${CMAKE_CURRENT_LIST_DIR}/../onnxruntime-${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}")
# set(ONNXRUNTIME_ROOTDIR "${CMAKE_CURRENT_LIST_DIR}/../onnxruntime-${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}")

set(ONNXRUNTIME_ROOTDIR "/home/galaxeus/Documents/hexaminate/app/ntts/native_lib/onnxruntime-Linux-x86_64")


# ADD_EXECUTABLE(piper ntts.cpp)

find_package(PkgConfig)
pkg_check_modules(ESPEAK_NG REQUIRED espeak-ng<2)


set(ntts_shared_dir "lib")
set(ntts_exe_dir "bin")
set(prefix_shared_library "lib")
 

message(STATUS "${CMAKE_CURRENT_LIST_DIR}/onnxruntime-${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}")
# set(ONNXRUNTIME_ROOTDIR "${CMAKE_CURRENT_LIST_DIR}/onnxruntime-${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}")
set(ONNXRUNTIME_ROOTDIR "/home/galaxeus/Documents/hexaminate/app/ntts/native_lib/onnxruntime-Linux-x86_64")

find_path(LIBESPEAK_INCLUDE_DIRS 
          NAMES speak_lib.h
          HINTS /usr/include/espeak)
find_library(LIBESPEAK_LIBRARIES
             NAMES espeak
             HINTS /usr/lib/ /usr/x86_64-linux-gnu/
             PATH_SUFFIXES lib)

              

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


add_library(ntts_shared SHARED ntts.cpp)
add_executable(ntts_exe ntts.cpp)

set_target_properties(ntts_shared PROPERTIES  
PUBLIC_HEADER /usr/include/espeak-ng/speak_lib.h
  LIBRARY_OUTPUT_DIRECTORY "${ntts_shared_dir}"
  PREFIX "${prefix_shared_library}"
  OUTPUT_NAME "${package_name}"
)

set_target_properties(ntts_exe PROPERTIES 
  RUNTIME_OUTPUT_DIRECTORY "${ntts_exe_dir}"
  OUTPUT_NAME "${package_name}"
)


target_link_libraries(ntts_exe 
                      onnxruntime
                      pthread
                      -static-libgcc -static-libstdc++
                      ${ESPEAK_NG_LIBRARIES}
                      ${PCAUDIO_LIBRARIES})

target_link_directories(ntts_exe PUBLIC
                        ${ESPEAK_NG_LIBRARY_DIRS}
                        ${ONNXRUNTIME_ROOTDIR}/lib)

target_include_directories(ntts_exe PUBLIC
                           ${ONNXRUNTIME_ROOTDIR}/include
                           ${ESPEAK_NG_INCLUDE_DIRS})

target_compile_options(ntts_exe PUBLIC
                       ${ESPEAK_NG_CFLAGS_OTHER})

                       target_link_libraries(ntts_shared
                       onnxruntime
                       pthread
                       -static-libgcc -static-libstdc++
                       ${ESPEAK_NG_LIBRARIES}
                       ${PCAUDIO_LIBRARIES})
 
target_link_libraries(ntts_shared 

onnxruntime
pthread
-static-libgcc -static-libstdc++
${ESPEAK_NG_LIBRARIES}
${PCAUDIO_LIBRARIES})
 
 target_link_directories(ntts_shared PUBLIC
                         ${ESPEAK_NG_LIBRARY_DIRS}
                         ${ONNXRUNTIME_ROOTDIR}/lib)
 
 target_include_directories(ntts_shared PUBLIC
                            ${ONNXRUNTIME_ROOTDIR}/include
                            ${ESPEAK_NG_INCLUDE_DIRS})
 
 target_compile_options(ntts_shared PUBLIC
                        ${ESPEAK_NG_CFLAGS_OTHER})

                        message(STATUS "S ${LIBESPEAK_INCLUDE_DIRS}")



# if (WIN32)
#  set_target_properties(ntts_shared PROPERTIES
#   WINDOWS_EXPORT_ALL_SYMBOLS ON
# )
# endif (WIN32)
 
add_custom_command(
  TARGET ntts_shared POST_BUILD 
  COMMAND ${CMAKE_STRIP} --strip-debug --strip-unneeded "${ntts_shared_dir}/${prefix_shared_library}ntts${package_shared_extension}"
)

# add_custom_command(
#   TARGET ntts_exe POST_BUILD 
#   COMMAND ${CMAKE_STRIP} --strip-debug --strip-unneeded "${ntts_exe_dir}/ntts${package_exe_extension}" 
# )

 