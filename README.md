# Docker environment to build the turtlebot3-stack
This repository provides a docker environment to build ROS 2 Jazzy as debian packages for arm64 to run Ubuntu 24.04 on the raspberry pi 3+ of the turtlebot 3.

These are unofficial packages, ros 2 jazzy is not supported by ROBOTIS.

## Prerequisites
Docker needs to be installed, only tested with docker-ce

## Building the image
Checkout and update this repo including all submodules: `git submodule update --init --recursive`

Run the `./cross-build.bash` script to install everything inside the docker package and build the packages
