# Docker Environment to create jazzy debian files from the turtlebot repos

## Prerequisites
Docker needs to be installed, only tested with docker-ce

## Building the image
Checkout and update this repo including all submodules: `git submodule update --init --recursive`

Run the `./cross-build.bash` script to install everything inside the docker package and build the packages