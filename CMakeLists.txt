cmake_minimum_required(VERSION 3.5)

file(READ ${CMAKE_SOURCE_DIR}/public.env ENV_CONTENTS)

# Read env file
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
# End read env file

# Set env vars
set(PROJECT_NAME $ENV{PROJECT_NAME})
# End set env vars

project(${PROJECT_NAME})

set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

# Add GLFW before defining the main executable
add_subdirectory(${CMAKE_SOURCE_DIR}/git_modules/GLFW)

# Find Vulkan and OpenGL
find_package(Vulkan REQUIRED)
find_package(OpenGL REQUIRED)

# Create the executable target first
add_executable(${PROJECT_NAME} main.cpp)

# Link the GLFW library, Vulkan, and OpenGL libraries to the executable
target_link_libraries(${PROJECT_NAME} glfw ${Vulkan_LIBRARIES} ${OPENGL_LIBRARIES})
