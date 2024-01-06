cmake_minimum_required(VERSION 3.27)

project(Trab)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wpedantic")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(
	trab
	src/trab.c
)
