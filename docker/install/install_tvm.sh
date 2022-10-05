#!/bin/bash
set -euxo pipefail

tvm_commit_hash=${1:-main}

# Clone and cd tvm
git clone https://github.com/apache/tvm.git --recursive
pushd tvm

# Checkout for target commit hash
git checkout ${tvm_commit_hash}

# Setting config.cmake
echo "set(CMAKE_BUILD_TYPE Release)" >> config.cmake
echo "set(USE_GRAPH_EXECUTOR ON)" >> config.cmake
echo "set(USE_LLVM llvm-config-12)" >> config.cmake

cmake -GNinja -H. -Bbuild
cmake --build build

cd python
python -m pip install -e .

popd

