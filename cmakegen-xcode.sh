#!/bin/bash

# Configure build variables.
BUILD_MODE=Debug
BUILD_DIR=./build

# Color configuration.
COLOR_OFF='\033[0m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'

PrintInfoMsg() {
    printf "${COLOR_GREEN} >> $1 ${COLOR_OFF}\n"
}

PrintErrorMsg() {
    printf "${COLOR_RED} >> $1 ${COLOR_OFF}\n"
}

CheckError() {
    if [ $? -eq 1 ]; then
        PrintErrorMsg "$1"
        exit 1
    fi
}

PrintInfoMsg "Creating a build directory..."

mkdir -p ${BUILD_DIR}
CheckError "Failed to make the build directory."

cd ${BUILD_DIR}

PrintInfoMsg "[Conan] Downloading third-party packages..."

conan install \
    --build missing \
    -s build_type=Debug \
    ..

conan install \
    --build missing \
    -s build_type=Release \
    ..

CheckError "[Conan] Failed to download and install required packages."

PrintInfoMsg "[CMake] Generating the project..."
cmake \
    -G Xcode \
    -DCMAKE_BUILD_TYPE:STRING=${BUILD_MODE} \
    ..
CheckError "[CMake] Failed to generate the project."

PrintInfoMsg "Project has been generated successfully!"
