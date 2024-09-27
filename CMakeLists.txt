cmake_minimum_required(VERSION 3.10)

# Set the project name and version
project(${PROJECT_NAME} VERSION 1.0)

# Use C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add the executable
add_executable(${PROJECT_NAME} main.cpp)

# Link Vulkan, GLFW, and other necessary libraries
find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)

target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan glfw glm dl pthread X11 Xxf86vm Xrandr Xi)
