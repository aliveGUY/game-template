cmake_minimum_required(VERSION 3.0)

file(READ ${CMAKE_SOURCE_DIR}/public.env ENV_CONTENTS)

# read env file
string(REPLACE "\n" ";" ENV_LINES "${ENV_CONTENTS}")
foreach(ENV_LINE ${ENV_LINES})
    string(FIND "${ENV_LINE}" "=" EQUAL_POS)
    if(NOT EQUAL_POS EQUAL -1)
        string(SUBSTRING "${ENV_LINE}" 0 ${EQUAL_POS} ENV_KEY)
        math(EXPR VALUE_START "${EQUAL_POS} + 1")
        string(SUBSTRING "${ENV_LINE}" ${VALUE_START} -1 ENV_VALUE)

        set(ENV{${ENV_KEY}} ${ENV_VALUE})
    endif()
endforeach()
# end read env file

# set env vars
set(PROJECT_NAME $ENV{PROJECT_NAME})
# end set env vars

project(${PROJECT_NAME} LANGUAGES C CXX)

set(CMAKE_C_COMPILER /usr/bin/clang)
set(CMAKE_CXX_COMPILER /usr/bin/clang++)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2")

# Find required packages and libraries
set(CMAKE_PREFIX_PATH "/usr/local")
find_package(glfw3 REQUIRED)
find_package(Vulkan REQUIRED)
find_package(Threads REQUIRED) # For pthread
find_package(X11 REQUIRED)      # For X11

# Add executable for the project
add_executable(${PROJECT_NAME} ./main.cpp)

# Link required libraries to the executable
target_link_libraries(${PROJECT_NAME}
    glfw
    Vulkan::Vulkan
    ${CMAKE_DL_LIBS}
    ${CMAKE_THREAD_LIBS_INIT}
    X11
    Xxf86vm
    Xrandr
    Xi
)
