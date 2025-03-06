ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}

# Basics for ROS 2 and to build debian packages
RUN apt-get update \
  && apt-get -y install \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-joint-state-publisher \
    libudev-dev \
    python3-bloom \
    python3-rosdep \
    fakeroot \
    debhelper \
    dh-python \
    && rm -rf /var/lib/apt/lists/*

# dependency packages for turtlebot3
RUN apt-get update \
  && apt-get -y install \
    ros-${ROS_DISTRO}-dynamixel-sdk \
    ros-${ROS_DISTRO}-dynamixel-workbench-msgs \
    ros-${ROS_DISTRO}-dynamixel-workbench \
    ros-${ROS_DISTRO}-hls-lfcd-lds-driver \
    ros-${ROS_DISTRO}-turtlebot3-msgs \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/ubuntu/colcon_ws/src
WORKDIR /home/ubuntu/colcon_ws

# build ld08_driver
COPY ./ld08_driver /home/ubuntu/colcon_ws/src/ld08_driver

RUN . /opt/ros/${ROS_DISTRO}/setup.sh\
    && cd src/ld08_driver \
    && bloom-generate rosdebian \
    && fakeroot debian/rules binary

# build turtlebot3
COPY ./turtlebot3/ /home/ubuntu/colcon_ws/src/turtlebot3

RUN for dir in turtlebot3_description \
    turtlebot3_node \
    turtlebot3_bringup \
    turtlebot3_example \
    turtlebot3_teleop \
    turtlebot3_cartographer \
    turtlebot3_navigation2 \
    turtlebot3; do \
      . /opt/ros/${ROS_DISTRO}/setup.sh\
      && cd src/turtlebot3/$dir \
      && bloom-generate rosdebian \
      && fakeroot debian/rules binary; \
    done

RUN mkdir /deb \
  && mv /home/ubuntu/colcon_ws/src/*.deb /deb/ \
  && mv /home/ubuntu/colcon_ws/src/*.ddeb /deb/

# COPY ./turtlebot3 /home/ubuntu/colcon_ws/src/turtlebot3
# RUN . /opt/ros/${ROS_DISTRO}/setup.sh\
#     && colcon build --packages-ignore dynamixel_sdk_examples

