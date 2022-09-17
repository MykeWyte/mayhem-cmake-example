# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /mayhem-cmake-example
WORKDIR /mayhem-cmake-example

## ADD YOUR BUILD INSTRUCTIONS HERE.
RUN rm -rf ./build
RUN mkdir build
WORKDIR build
RUN CC=clang CXX=clang++ cmake ..
RUN make

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## Path in builder stage
COPY --from=builder /mayhem-cmake-example/build/fuzzme /

