# Lab 05 Report - Build Systems

## Part 1

### Step 1/2

TutorialConfig.h.in
```
// the configured options and settings for Tutorial
#define Tutorial_VERSION_MAJOR @Tutorial_VERSION_MAJOR@
#define Tutorial_VERSION_MINOR @Tutorial_VERSION_MINOR@
#cmakedefine USE_MYMATH
```

tutorial.cxx
```
// A simple program that computes the square root of a number
#include <cmath>
#include <iostream>
#include <string>
#include "TutorialConfig.h"

int main(int argc, char* argv[])
{
  if (argc < 2) {
    // report version
    std::cout << argv[0] << " Version " << Tutorial_VERSION_MAJOR << "." << Tutorial_VERSION_MINOR << std::endl;
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  // convert input to double
  const double inputValue = std::stod(argv[1]);

  // calculate square root
  const double outputValue = sqrt(inputValue);
  std::cout << "The square root of " << inputValue << " is " << outputValue
            << std::endl;
  return 0;
}

```

CMakeLists.txt
```
cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library
if(USE_MYMATH)
    add_subdirectory(MathFunctions)
    list(APPEND EXTRA_LIBS MathFunctions)
    list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")
endif()

# add the executable
add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
		  	   ${EXTRA_INCLUDES}
                           )
```

<img src="step2tutorial.png" width=600>

### Step 3

CMakeLists.txt
```
cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# should we use our own math functions
option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library
if(USE_MYMATH)
  add_subdirectory(MathFunctions)
  list(APPEND EXTRA_LIBS MathFunctions)
endif()

# add the executable
add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )
```

MathFunctions/CMakeLists.txt
```
add_library(MathFunctions mysqrt.cxx)

target_include_directories(MathFunctions
	INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
	)
```

<img src="step3tutorial.png" width=600>

### Step 4

CMakeLists.txt
```
cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# should we use our own math functions
option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library
if(USE_MYMATH)
  add_subdirectory(MathFunctions)
  list(APPEND EXTRA_LIBS MathFunctions)
endif()

# add the executable
add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )


enable_testing()

# does the application run
add_test(NAME Runs COMMAND Tutorial 25)

# does the usage message work?
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

# define a function to simplify adding tests
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

# do a bunch of result based tests
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")
```

MathFunctions/CMakeLists.txt
```
add_library(MathFunctions mysqrt.cxx)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )

install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
```

ctest output
```
UpdateCTestConfiguration  from :/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/cmake/Help/guide/tutorial/Step4_build/DartConfiguration.tcl
UpdateCTestConfiguration  from :/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/cmake/Help/guide/tutorial/Step4_build/DartConfiguration.tcl
Test project /mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/cmake/Help/guide/tutorial/Step4_build
Constructing a list of tests
Done constructing a list of tests
Updating test list for fixtures
Added 0 tests to meet fixture requirements
Checking test dependency graph...
Checking test dependency graph end
test 1
    Start 1: Runs

1: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "25"
1: Test timeout computed to be: 9.99988e+06
1: Computing sqrt of 25 to be 13
1: Computing sqrt of 25 to be 7.46154
1: Computing sqrt of 25 to be 5.40603
1: Computing sqrt of 25 to be 5.01525
1: Computing sqrt of 25 to be 5.00002
1: Computing sqrt of 25 to be 5
1: Computing sqrt of 25 to be 5
1: Computing sqrt of 25 to be 5
1: Computing sqrt of 25 to be 5
1: Computing sqrt of 25 to be 5
1: The square root of 25 is 5
1/9 Test #1: Runs .............................   Passed    0.28 sec
test 2
    Start 2: Usage

2: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial
2: Test timeout computed to be: 9.99988e+06
2: /mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial Version 1.0
2: Usage: /mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial number
2/9 Test #2: Usage ............................   Passed    0.14 sec
test 3
    Start 3: Comp4

3: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "4"
3: Test timeout computed to be: 9.99988e+06
3: Computing sqrt of 4 to be 2.5
3: Computing sqrt of 4 to be 2.05
3: Computing sqrt of 4 to be 2.00061
3: Computing sqrt of 4 to be 2
3: Computing sqrt of 4 to be 2
3: Computing sqrt of 4 to be 2
3: Computing sqrt of 4 to be 2
3: Computing sqrt of 4 to be 2
3: Computing sqrt of 4 to be 2
3: Computing sqrt of 4 to be 2
3: The square root of 4 is 2
3/9 Test #3: Comp4 ............................   Passed    0.15 sec
test 4
    Start 4: Comp9

4: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "9"
4: Test timeout computed to be: 9.99988e+06
4: Computing sqrt of 9 to be 5
4: Computing sqrt of 9 to be 3.4
4: Computing sqrt of 9 to be 3.02353
4: Computing sqrt of 9 to be 3.00009
4: Computing sqrt of 9 to be 3
4: Computing sqrt of 9 to be 3
4: Computing sqrt of 9 to be 3
4: Computing sqrt of 9 to be 3
4: Computing sqrt of 9 to be 3
4: Computing sqrt of 9 to be 3
4: The square root of 9 is 3
4/9 Test #4: Comp9 ............................   Passed    0.15 sec
test 5
    Start 5: Comp5

5: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "5"
5: Test timeout computed to be: 9.99988e+06
5: Computing sqrt of 5 to be 3
5: Computing sqrt of 5 to be 2.33333
5: Computing sqrt of 5 to be 2.2381
5: Computing sqrt of 5 to be 2.23607
5: Computing sqrt of 5 to be 2.23607
5: Computing sqrt of 5 to be 2.23607
5: Computing sqrt of 5 to be 2.23607
5: Computing sqrt of 5 to be 2.23607
5: Computing sqrt of 5 to be 2.23607
5: Computing sqrt of 5 to be 2.23607
5: The square root of 5 is 2.23607
5/9 Test #5: Comp5 ............................   Passed    0.15 sec
test 6
    Start 6: Comp7

6: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "7"
6: Test timeout computed to be: 9.99988e+06
6: Computing sqrt of 7 to be 4
6: Computing sqrt of 7 to be 2.875
6: Computing sqrt of 7 to be 2.65489
6: Computing sqrt of 7 to be 2.64577
6: Computing sqrt of 7 to be 2.64575
6: Computing sqrt of 7 to be 2.64575
6: Computing sqrt of 7 to be 2.64575
6: Computing sqrt of 7 to be 2.64575
6: Computing sqrt of 7 to be 2.64575
6: Computing sqrt of 7 to be 2.64575
6: The square root of 7 is 2.64575
6/9 Test #6: Comp7 ............................   Passed    0.15 sec
test 7
    Start 7: Comp25

7: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "25"
7: Test timeout computed to be: 9.99988e+06
7: Computing sqrt of 25 to be 13
7: Computing sqrt of 25 to be 7.46154
7: Computing sqrt of 25 to be 5.40603
7: Computing sqrt of 25 to be 5.01525
7: Computing sqrt of 25 to be 5.00002
7: Computing sqrt of 25 to be 5
7: Computing sqrt of 25 to be 5
7: Computing sqrt of 25 to be 5
7: Computing sqrt of 25 to be 5
7: Computing sqrt of 25 to be 5
7: The square root of 25 is 5
7/9 Test #7: Comp25 ...........................   Passed    0.15 sec
test 8
    Start 8: Comp-25

8: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "-25"
8: Test timeout computed to be: 9.99988e+06
8: The square root of -25 is 0
8/9 Test #8: Comp-25 ..........................   Passed    0.14 sec
test 9
    Start 9: Comp0.0001

9: Test command: /mnt/c/users/Zachary\ McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/lab-05/cmake/Help/guide/tutorial/Step4_build/Tutorial "0.0001"
9: Test timeout computed to be: 9.99988e+06
9: Computing sqrt of 0.0001 to be 0.50005
9: Computing sqrt of 0.0001 to be 0.250125
9: Computing sqrt of 0.0001 to be 0.125262
9: Computing sqrt of 0.0001 to be 0.0630304
9: Computing sqrt of 0.0001 to be 0.0323084
9: Computing sqrt of 0.0001 to be 0.0177018
9: Computing sqrt of 0.0001 to be 0.0116755
9: Computing sqrt of 0.0001 to be 0.0101202
9: Computing sqrt of 0.0001 to be 0.0100007
9: Computing sqrt of 0.0001 to be 0.01
9: The square root of 0.0001 is 0.01
9/9 Test #9: Comp0.0001 .......................   Passed    0.15 sec

100% tests passed, 0 tests failed out of 9

Total Test time (real) =   1.54 sec
```

### Step 5

CMakeLists.txt
```
cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# should we use our own math functions
option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library
if(USE_MYMATH)
  add_subdirectory(MathFunctions)
  list(APPEND EXTRA_LIBS MathFunctions)
endif()

# add the executable
add_executable(Tutorial tutorial.cxx)
target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

# add the install targets
install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )

# enable testing
enable_testing()

# does the application run
add_test(NAME Runs COMMAND Tutorial 25)

# does the usage message work?
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

# define a function to simplify adding tests
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

# do a bunch of result based tests
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")
```

MathFunctions/CMakeLists.txt
```
add_library(MathFunctions mysqrt.cxx)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )

# does this system provide the log and exp functions?
include(CheckSymbolExists)
check_symbol_exists(log "math.h" HAVE_LOG)
check_symbol_exists(exp "math.h" HAVE_EXP)
if(NOT (HAVE_LOG AND HAVE_EXP))
  unset(HAVE_LOG CACHE)
  unset(HAVE_EXP CACHE)
  set(CMAKE_REQUIRED_LIBRARIES "m")
  check_symbol_exists(log "math.h" HAVE_LOG)
  check_symbol_exists(exp "math.h" HAVE_EXP)
  if(HAVE_LOG AND HAVE_EXP)
    target_link_libraries(MathFunctions PRIVATE m)
  endif()
endif()

if(HAVE_LOG AND HAVE_EXP)
  target_compile_definitions(MathFunctions
		PRIVATE "HAVE_LOG" "HAVE_EXP")
endif()

# install rules
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
```

<img src="step5tutorial.png" width=600>

## Part 2

Makefile
```
all: static_block dynamic_block

static_block: program.o staticlib.a
	cc -o static_block program.o staticlib.a
dynamic_block: program.o sharedlib.so
	cc program.o sharedlib.so -o dynamic_block -Wl,-rpath .
block.o: source/block.c
	cc -fPIC -c source/block.c -o block.o
program.o: program.c
	cc -c program.c -o program.o
staticlib.a: block.o
	ar -rcs staticlib.a block.o
sharedlib.so: block.o
	cc -shared -o sharedlib.so block.o
clean:
	rm static_block dynamic_block block.o sharedlib.so staticlib.a
```

CMakeLists.txt
```
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
```

Makefile made by cmake
```
# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Default target executed when no arguments are given to make.
default_target: all

.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2"

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache

.PHONY : rebuild_cache/fast

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "No interactive CMake dialog available..."
	/usr/bin/cmake -E echo No\ interactive\ CMake\ dialog\ available.
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache

.PHONY : edit_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/CMakeFiles" "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/CMakeFiles/progress.marks"
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/CMakeFiles" 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean

.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named SHARED

# Build rule for target.
SHARED: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 SHARED
.PHONY : SHARED

# fast build rule for target.
SHARED/fast:
	$(MAKE) -f CMakeFiles/SHARED.dir/build.make CMakeFiles/SHARED.dir/build
.PHONY : SHARED/fast

#=============================================================================
# Target rules for targets named SharedLib

# Build rule for target.
SharedLib: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 SharedLib
.PHONY : SharedLib

# fast build rule for target.
SharedLib/fast:
	$(MAKE) -f CMakeFiles/SharedLib.dir/build.make CMakeFiles/SharedLib.dir/build
.PHONY : SharedLib/fast

#=============================================================================
# Target rules for targets named StaticLib

# Build rule for target.
StaticLib: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 StaticLib
.PHONY : StaticLib

# fast build rule for target.
StaticLib/fast:
	$(MAKE) -f CMakeFiles/StaticLib.dir/build.make CMakeFiles/StaticLib.dir/build
.PHONY : StaticLib/fast

#=============================================================================
# Target rules for targets named STATIC

# Build rule for target.
STATIC: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 STATIC
.PHONY : STATIC

# fast build rule for target.
STATIC/fast:
	$(MAKE) -f CMakeFiles/STATIC.dir/build.make CMakeFiles/STATIC.dir/build
.PHONY : STATIC/fast

program.o: program.c.o

.PHONY : program.o

# target to build an object file
program.c.o:
	$(MAKE) -f CMakeFiles/SHARED.dir/build.make CMakeFiles/SHARED.dir/program.c.o
	$(MAKE) -f CMakeFiles/STATIC.dir/build.make CMakeFiles/STATIC.dir/program.c.o
.PHONY : program.c.o

program.i: program.c.i

.PHONY : program.i

# target to preprocess a source file
program.c.i:
	$(MAKE) -f CMakeFiles/SHARED.dir/build.make CMakeFiles/SHARED.dir/program.c.i
	$(MAKE) -f CMakeFiles/STATIC.dir/build.make CMakeFiles/STATIC.dir/program.c.i
.PHONY : program.c.i

program.s: program.c.s

.PHONY : program.s

# target to generate assembly for a file
program.c.s:
	$(MAKE) -f CMakeFiles/SHARED.dir/build.make CMakeFiles/SHARED.dir/program.c.s
	$(MAKE) -f CMakeFiles/STATIC.dir/build.make CMakeFiles/STATIC.dir/program.c.s
.PHONY : program.c.s

source/block.o: source/block.c.o

.PHONY : source/block.o

# target to build an object file
source/block.c.o:
	$(MAKE) -f CMakeFiles/SharedLib.dir/build.make CMakeFiles/SharedLib.dir/source/block.c.o
	$(MAKE) -f CMakeFiles/StaticLib.dir/build.make CMakeFiles/StaticLib.dir/source/block.c.o
.PHONY : source/block.c.o

source/block.i: source/block.c.i

.PHONY : source/block.i

# target to preprocess a source file
source/block.c.i:
	$(MAKE) -f CMakeFiles/SharedLib.dir/build.make CMakeFiles/SharedLib.dir/source/block.c.i
	$(MAKE) -f CMakeFiles/StaticLib.dir/build.make CMakeFiles/StaticLib.dir/source/block.c.i
.PHONY : source/block.c.i

source/block.s: source/block.c.s

.PHONY : source/block.s

# target to generate assembly for a file
source/block.c.s:
	$(MAKE) -f CMakeFiles/SharedLib.dir/build.make CMakeFiles/SharedLib.dir/source/block.c.s
	$(MAKE) -f CMakeFiles/StaticLib.dir/build.make CMakeFiles/StaticLib.dir/source/block.c.s
.PHONY : source/block.c.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... rebuild_cache"
	@echo "... edit_cache"
	@echo "... SHARED"
	@echo "... SharedLib"
	@echo "... StaticLib"
	@echo "... STATIC"
	@echo "... program.o"
	@echo "... program.i"
	@echo "... program.s"
	@echo "... source/block.o"
	@echo "... source/block.i"
	@echo "... source/block.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system


```

The static version is 8464 bytes, and the shared version is 8296 bytes, so the shared version is 168 bytes smaller.

<img src="part2output.png" width=600>