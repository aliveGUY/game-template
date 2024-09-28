FROM nvidia/cuda:12.6.1-cudnn-runtime-ubuntu24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
  vulkan-tools \
  vulkan-utility-libraries-dev \
  spirv-tools \
  wayland-protocols \
  libvulkan-dev \
  libglm-dev \
  libxxf86vm-dev \
  libxi-dev \
  libwayland-dev \
  libx11-dev \
  libxkbcommon-dev \
  libxrandr-dev \
  libxinerama-dev \
  libxcursor-dev \
  libxrender-dev \
  libgl1-mesa-dev \
  clang \
  cmake \
  wget \
  pkg-config \
  git \
  tree

# Install GLFW from source
RUN git clone https://github.com/glfw/glfw.git
RUN cmake -S glfw -B glfw_build
RUN cmake --build glfw_build --target install

# Install shader compiler
RUN wget https://storage.googleapis.com/shaderc/artifacts/prod/graphics_shader_compiler/shaderc/linux/continuous_clang_release/469/20240923-182119/install.tgz
RUN tar -xvzf install.tgz
RUN mv install/bin/glslc /usr/local/bin

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}

COPY . /${PROJECT_NAME}
WORKDIR /${PROJECT_NAME}

RUN cmake -S . -B build
RUN cmake --build build

CMD ["bash", "./lde.sh", "--run"]
