#!/bin/bash

# Install Python package 'requests'
python -m pip install --upgrade pip
pip install requests
pip install gitpython
pip install "virtualenv<20"

# Install latest Polly toolchains and scripts
wget https://github.com/cpp-pm/polly/archive/master.zip
unzip master.zip
POLLY_ROOT="`pwd`/polly-master"
export PATH="${POLLY_ROOT}/bin:${PATH}"

# Install dependencies (CMake, Android NDK)
install-ci-dependencies.py --prune-archives

# Tune locations
export PATH="`pwd`/_ci/cmake/bin:${PATH}"

# Installed if toolchain is Android (otherwise directory doesn't exist)
export ANDROID_NDK_r10e="`pwd`/_ci/android-ndk-r10e"
export ANDROID_NDK_r11c="`pwd`/_ci/android-ndk-r11c"
export ANDROID_NDK_r15c="`pwd`/_ci/android-ndk-r15c"
export ANDROID_NDK_r16b="`pwd`/_ci/android-ndk-r16b"
export ANDROID_NDK_r17="`pwd`/_ci/android-ndk-r17"

# OSX - Use Xcode 11.3.1 instead of default 11.6
export DEVELOPER_DIR="/Applications/Xcode_11.3.1.app/Contents/Developer"

# Run build script
python jenkins.py