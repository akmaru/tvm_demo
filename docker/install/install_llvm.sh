#!/bin/bash
set -euxo pipefail

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main\
     >> /etc/apt/sources.list.d/llvm.list
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main\
     >> /etc/apt/sources.list.d/llvm.list


echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main\
     >> /etc/apt/sources.list.d/llvm.list
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main\
     >> /etc/apt/sources.list.d/llvm.list

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main\
     >> /etc/apt/sources.list.d/llvm.list
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main\
     >> /etc/apt/sources.list.d/llvm.list

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main\
     >> /etc/apt/sources.list.d/llvm.list
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main\
     >> /etc/apt/sources.list.d/llvm.list

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main\
     >> /etc/apt/sources.list.d/llvm.list
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main\
     >> /etc/apt/sources.list.d/llvm.list

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main\
     >> /etc/apt/sources.list.d/llvm.list
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main\
     >> /etc/apt/sources.list.d/llvm.list

wget -q -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -

apt-get update && apt install -y \
     llvm-9 llvm-10 llvm-11 llvm-12 llvm-13 \
     clang-9 libclang-9-dev \
     clang-10 libclang-10-dev \
     clang-11 libclang-11-dev \
     clang-12 libclang-12-dev \
     clang-13 libclang-13-dev \
     && apt-get clean && rm -rf /var/lib/apt/lists/*

