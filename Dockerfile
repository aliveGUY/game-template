FROM ubuntu:latest

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}

RUN apt-get -y update && apt-get install -y \
  clang \
  cmake \
  wayland-protocols \
  libwayland-dev \
  pkg-config \
  libx11-dev \
  libxkbcommon-dev \
  libxrandr-dev \
  libxinerama-dev \
  libxcursor-dev \
  libxi-dev \
  libxrender-dev \
  libgl1-mesa-dev \
  libvulkan-dev \
  x11-apps

# Create a runtime directory and set the XDG_RUNTIME_DIR environment variable
RUN mkdir -p /run/user/1000 && chown root:root /run/user/1000 && chmod 700 /run/user/1000
ENV XDG_RUNTIME_DIR=/run/user/1000

COPY . /usr/src/${PROJECT_NAME}

WORKDIR /usr/src/${PROJECT_NAME}

RUN cmake -S . -B build
RUN cmake --build build

CMD ["bash", "./lde.sh", "--run"]
