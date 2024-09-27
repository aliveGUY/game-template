FROM ubuntu:latest

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}

RUN apt-get -y update && apt-get install -y

RUN apt-get install -y clang
RUN apt-get install -y cmake

COPY . /usr/src/${PROJECT_NAME}

WORKDIR /usr/src/${PROJECT_NAME}

RUN cmake -S . -B build
RUN cmake --build build

CMD ["bash", "./lde.sh", "--run"]
