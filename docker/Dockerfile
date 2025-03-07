ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}

# Basics for ROS 2 and to build debian packages
RUN apt-get update \
  && apt-get -y install \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-cartographer-ros \
    ros-${ROS_DISTRO}-nav2-bringup \
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

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_description && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-description*.deb

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_node && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-node*.deb

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_example && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-example*.deb

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_teleop && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary


RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-teleop*.deb

COPY ./turtlebot3.list /etc/ros/rosdep/sources.list.d/99-turtlebot3.list
COPY ./turtlebot3.yaml /opt/ros/turtlebot3.yaml

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  rosdep update

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_bringup && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-bringup*.deb

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_cartographer && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-cartographer*.deb

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3_navigation2 && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3-navigation2*.deb

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd /home/ubuntu/colcon_ws/src/turtlebot3/turtlebot3 && \
  bloom-generate rosdebian && \
  fakeroot debian/rules binary

RUN dpkg -i ./src/turtlebot3/ros-${ROS_DISTRO}-turtlebot3*.deb

RUN mkdir /deb \
  && mv /home/ubuntu/colcon_ws/src/*.deb /deb/ \
  && mv /home/ubuntu/colcon_ws/src/*.ddeb /deb/ \
  && mv /home/ubuntu/colcon_ws/src/turtlebot3/*.deb /deb/ \
  && mv /home/ubuntu/colcon_ws/src/turtlebot3/*.ddeb /deb/