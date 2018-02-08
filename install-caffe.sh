#!/bin/bash
# install common deps
set -e
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential cmake make
sudo apt-get install libboost-all-dev libleveldb-dev  \
                     libsnappy-dev libhdf5-serial-dev \
                     libgflags-dev libgoogle-glog-dev liblmdb-dev \
                     libatlas-base-dev python-dev
# install protobuf
if [[ "$(which protoc)" == '' ]]; then
  echo "Install Protobuf..."
  bash install-protobuf.sh
fi
# install OpenCV
if [[ "$(which opencv_version)" == '' ]]; then
    echo "Installing OpenCV ..."
    sudo bash install-opencv.sh
fi
# install python deps
if [[ "$(which pip)" == '' ]]; then
    # curl https://bootstrap.pypa.io/get-pip.py
    # alternative link for CN users
    curl http://zhaok-data.oss-cn-shanghai.aliyuncs.com/service/get-pip.py | sudo -H python
else
    sudo -H pip install --upgrade pip
fi
sudo -H pip install -r requirements.txt
. ~/.bashrc
# sudo apt-get install python-tk  # tkinter cannot install with pip
# clone latest caffe source code
cd ~/ && git clone https://github.com/BVLC/caffe --depth 1 && cd caffe
mkdir build && cd build
cmake -DCPU_ONLY=ON .. && make -j$(nproc)
## some other cmake examples ##
# build with cuda, cudnn and nccl
# cmake -USE_NCCL=ON -DNCCL_INCLUDE_DIR=/pkg/nccl/include -DNCCL_LIBRARIES=/pkg/nccl/lib \
# -DCUDNN_INCLUDE=/usr/local/cudnn/include -DCUDNN_LIBRARY=/usr/local/cudnn/lib64 ..

echo "Done! Built caffe source at '~/caffe'"

# try caffe MNIST example:
# cd ~/caffe
# bash data/mnist/get_mnist.sh
# bash examples/mnist/create_mnist.sh
# bash examples/mnist/train_lenet.sh
