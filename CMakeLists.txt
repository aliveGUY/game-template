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

project(${PROJECT_NAME})

include_directories(${CMAKE_SOURCE_DIR}/git_modules/GuiLite)

add_executable(${PROJECT_NAME} main.cpp)
