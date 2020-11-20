#!/bin/sh

set -e

docker run --rm -v $PWD:$PWD ubuntu:20.04 $PWD/build_ubuntu_inside_docker.sh
