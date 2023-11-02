#!/bin/bash

# Define the number of threads for compilation based on the number of CPUs
no_threads=$(nproc)

# Update the system and install necessary packages
apt update && apt install -y git \
                             build-essential \
                             gcc \
                             g++ \
                             cmake \
                             autoconf \
                             clang \
                             libomp5 \
                             python3 \
                             python3-pip \
                             libomp-dev \
                             doxygen \
                             graphviz \
                             libboost-all-dev \

# Install Python packages
pip install --no-cache-dir "pybind11[global]"
pip install --no-cache-dir numpy

# Disable SSL verification for git if necessary
git config --global http.sslverify "false"



# Building OpenFHE
cd openfhe-development
mkdir -p build && cd build
cmake ..
make -j$no_threads
make install
cd ..

#installing OpenFHE Python
cd openfhe-python
mkdir -p build && cd build
cmake ..
make -j$no_threads
make install
cd ..



# Additional commands or cleanup can go here
