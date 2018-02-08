#!/bin/bash
set -e
sudo apt-get install autoconf automake libtool curl make g++ unzip
if [ ! -e /tmp/protobuf-cpp-3.4.1.tar.gz ]; then
  #wget --directory-prefix=/tmp/ https://github.com/google/protobuf/releases/download/v3.4.1/protobuf-cpp-3.4.1.tar.gz
  wget --directory-prefix=/tmp/ http://zhaok-data.oss-cn-shanghai.aliyuncs.com/service/protobuf/protobuf-cpp-3.4.1.tar.gz
fi
cd /tmp
tar -xvf protobuf-cpp-3.4.1.tar.gz
cd protobuf-3.4.1
./autogen.sh
./configure
make -j$(nproc)
make check -j$(nproc)
sudo make install -j$(nproc)
sudo ldconfig
echo 'Done!'

