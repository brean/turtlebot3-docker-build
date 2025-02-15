ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}

RUN apt-get update \
  && apt-get -y install \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-turtlebot3-msgs \
    libudev-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/ubuntu/colcon_ws/src
COPY ./DynamixelSDK /home/ubuntu/colcon_ws/src/DynamixelSDK
COPY ./hls_lfcd_lds_driver /home/ubuntu/colcon_ws/src/hls_lfcd_lds_driver
COPY ./ld08_driver /home/ubuntu/colcon_ws/src/ld08_driver
COPY ./turtlebot3 /home/ubuntu/colcon_ws/src/turtlebot3

WORKDIR /home/ubuntu/colcon_ws
RUN . /opt/ros/${ROS_DISTRO}/setup.sh\
    && colcon build