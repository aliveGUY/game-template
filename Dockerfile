FROM nvidia/cuda:12.6.1-cudnn-runtime-ubuntu24.04

RUN apt-get update && apt-get install -y \
  libvulkan1 \
  vulkan-tools \
  mesa-vulkan-drivers \
  xorg \
  libglvnd-dev && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["vkcube"]
