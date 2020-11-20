#!/bin/sh

set -e

apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    g++ make unzip patch lsb-release

SCRIPT_DIR=$(dirname "$0")
case $SCRIPT_DIR in
    "/"*)
        ;;
    ".")
        SCRIPT_DIR=$(pwd)
        ;;
    *)
        SCRIPT_DIR=$(pwd)/$(dirname "$0")
        ;;
esac

cd /tmp
unzip $SCRIPT_DIR/libecwj2-3.3-2006-09-06.zip
patch -p0 < $SCRIPT_DIR/libecwj2-3.3.patch
cd libecwj2-3.3
CFLAGS=-O2 CXXFLAGS=-O2 ./configure --prefix=/opt/libecwj2-3.3
make -j$(nproc)
mkdir -p /opt/libecwj2-3.3/include
make install
cd /
tar cvzf $SCRIPT_DIR/install-libecwj2-3.3-ubuntu-$(lsb_release -rs).tar.gz /opt/libecwj2-3.3
