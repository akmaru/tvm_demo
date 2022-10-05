#!/bin/bash
set -euxo pipefail

CMAKE_VERSION=3.24.2
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.sh
chmod +x cmake-${CMAKE_VERSION}-linux-x86_64.sh
./cmake-${CMAKE_VERSION}-linux-x86_64.sh --skip-license --prefix=/usr/local
rm cmake-${CMAKE_VERSION}-linux-x86_64.sh

