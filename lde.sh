#!/bin/bash

source public.env

build_docker=false
run_docker=false
build_cpp=false
run_cpp=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
    -bd | --build-docker) build_docker=true ;;
    -rd | --run-docker) run_docker=true ;;
    -b | --build) build_cpp=true ;;
    -r | --run) run_cpp=true ;;
    *) echo "Unknown parameter: $1" ;;
    esac
    shift
done

if $build_docker; then
    echo "  ~docker build . -t $PROJECT_NAME"
    docker build . -t $PROJECT_NAME --build-arg PROJECT_NAME=$PROJECT_NAME
fi

if $run_docker; then
    echo "  ~docker run $PROJECT_NAME"
    docker run $PROJECT_NAME
fi

if $build_cpp; then
    echo "  ~cmake -S . -B build"
    cmake -S . -B build

    echo "  ~cmake --build build"
    cmake --build build
fi

if $run_cpp; then
    echo "./build/${PROJECT_NAME}"
    ./build/$PROJECT_NAME
fi
