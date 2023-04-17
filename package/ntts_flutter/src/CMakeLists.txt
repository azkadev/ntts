# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ntts_flutter_library VERSION 0.0.1 LANGUAGES C)

add_library(ntts_flutter SHARED
  "ntts_flutter.c"
)

set_target_properties(ntts_flutter PROPERTIES
  PUBLIC_HEADER ntts_flutter.h
  OUTPUT_NAME "ntts_flutter"
)

target_compile_definitions(ntts_flutter PUBLIC DART_SHARED_LIB)
