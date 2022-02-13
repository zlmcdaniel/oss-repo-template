cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Block VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_library(StaticLib STATIC source/block.c)

add_executable(STATIC program.c)

target_link_libraries(STATIC StaticLib)

add_library(SharedLib SHARED source/block.c)

add_executable(SHARED program.c)

target_link_libraries(SHARED SharedLib)