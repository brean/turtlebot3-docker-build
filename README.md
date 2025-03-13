# Docker environment to build the turtlebot3-stack
This repository provides a docker environment to build ROS 2 Jazzy as debian packages for arm64 to run Ubuntu 24.04 on the raspberry pi 3+ of the turtlebot 3.

These are unofficial packages, ros 2 jazzy is not supported by ROBOTIS.

## Prerequisites
Docker needs to be installed, only tested with docker-ce

## Building the image
You do NOT need to build the images if you just want to install the build packages, you can just download them from the [Release-Page](https://github.com/brean/turtlebot3-docker-build/releases/tag/ros-jazzy-turtlebot3_2.2.0-0noble_arm64)

Checkout and update this repo including all submodules: `git submodule update --init --recursive`

Run the `./build.bash` script to install everything inside the docker package and build the packages, after the build is complete (which takes around 30 minutes on modern hardware) you'll find the debian packages in the `deb-<arch>`-folders where `<arch>` is either arm64 or amd64.
