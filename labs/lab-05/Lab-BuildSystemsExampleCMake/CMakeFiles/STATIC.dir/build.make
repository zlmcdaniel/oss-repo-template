# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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

# Include any dependencies generated for this target.
include CMakeFiles/STATIC.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/STATIC.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/STATIC.dir/flags.make

CMakeFiles/STATIC.dir/program.c.o: CMakeFiles/STATIC.dir/flags.make
CMakeFiles/STATIC.dir/program.c.o: program.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/STATIC.dir/program.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/STATIC.dir/program.c.o   -c "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/program.c"

CMakeFiles/STATIC.dir/program.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/STATIC.dir/program.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/program.c" > CMakeFiles/STATIC.dir/program.c.i

CMakeFiles/STATIC.dir/program.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/STATIC.dir/program.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/program.c" -o CMakeFiles/STATIC.dir/program.c.s

CMakeFiles/STATIC.dir/program.c.o.requires:

.PHONY : CMakeFiles/STATIC.dir/program.c.o.requires

CMakeFiles/STATIC.dir/program.c.o.provides: CMakeFiles/STATIC.dir/program.c.o.requires
	$(MAKE) -f CMakeFiles/STATIC.dir/build.make CMakeFiles/STATIC.dir/program.c.o.provides.build
.PHONY : CMakeFiles/STATIC.dir/program.c.o.provides

CMakeFiles/STATIC.dir/program.c.o.provides.build: CMakeFiles/STATIC.dir/program.c.o


# Object files for target STATIC
STATIC_OBJECTS = \
"CMakeFiles/STATIC.dir/program.c.o"

# External object files for target STATIC
STATIC_EXTERNAL_OBJECTS =

STATIC: CMakeFiles/STATIC.dir/program.c.o
STATIC: CMakeFiles/STATIC.dir/build.make
STATIC: libStaticLib.a
STATIC: CMakeFiles/STATIC.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable STATIC"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/STATIC.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/STATIC.dir/build: STATIC

.PHONY : CMakeFiles/STATIC.dir/build

CMakeFiles/STATIC.dir/requires: CMakeFiles/STATIC.dir/program.c.o.requires

.PHONY : CMakeFiles/STATIC.dir/requires

CMakeFiles/STATIC.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/STATIC.dir/cmake_clean.cmake
.PHONY : CMakeFiles/STATIC.dir/clean

CMakeFiles/STATIC.dir/depend:
	cd "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2" "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2" "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2" "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2" "/mnt/c/users/Zachary McDaniel/Desktop/College/OpenSourceSoftware/oss-repo-template/labs/Lab-05/Lab-BuildSystemsExample2/CMakeFiles/STATIC.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/STATIC.dir/depend

