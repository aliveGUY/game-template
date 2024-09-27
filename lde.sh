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
    -rd | --refresh-docker) run_docker=true ;;
    -b | --build) build_cpp=true ;;
    -r | --run) run_cpp=true ;;
    *) echo "Unknown parameter: $1" ;;
    esac
    shift
done

if $build_docker; then
    docker build . -t $PROJECT_NAME --build-arg PROJECT_NAME=$PROJECT_NAME
fi

if $run_docker; then
    xhost +local:docker
    docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $PROJECT_NAME xclock

fi

if $build_cpp; then
    cmake -S . -B build
    cmake --build build
fi

if $run_cpp; then
    ./build/$PROJECT_NAME
fi
