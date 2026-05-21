FROM ros:humble

## Install ROS dependencies and code-server
ARG CODE_SERVER_VERSION=4.91.0
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
            ros-${ROS_DISTRO}-desktop \
            ros-${ROS_DISTRO}-rmw-fastrtps-cpp \
            ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
            ros-${ROS_DISTRO}-navigation2 \
            ros-${ROS_DISTRO}-nav2-bringup \
            ros-${ROS_DISTRO}-slam-toolbox \
            ros-${ROS_DISTRO}-rviz2 \
            ros-${ROS_DISTRO}-tf2-tools \
            ros-${ROS_DISTRO}-rqt-tf-tree \
            ros-${ROS_DISTRO}-moveit \
            ros-${ROS_DISTRO}-controller-manager \
            ros-${ROS_DISTRO}-joint-trajectory-controller \
            ros-${ROS_DISTRO}-joint-state-broadcaster \
            ros-${ROS_DISTRO}-joint-state-publisher \
            ros-${ROS_DISTRO}-vision-opencv \
            ros-${ROS_DISTRO}-teleop-twist-joy \
            ros-${ROS_DISTRO}-joy \
            curl \
            ca-certificates \    
            git \
            python3-pip \
            python3-colcon-common-extensions \
            python3-rosdep \
            python3-dev \
            build-essential \
            curl \
            qtdeclarative5-dev && \
        curl -fOL https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb && \
        apt-get install -y --no-install-recommends ./code-server_${CODE_SERVER_VERSION}_amd64.deb && \
        rm -f code-server_${CODE_SERVER_VERSION}_amd64.deb && \
        rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV ROS_DISCOVERY_SERVER=127.0.0.1:11811
ENV TERM=xterm-256color
ENV NO_AT_BRIDGE=1
ENV QT_X11_NO_MITSHM=1
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Default workspace served by code-server
WORKDIR /workspace

# Expose code-server port
EXPOSE 8080

# Copy entrypoint script
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

# Ensure the entrypoint script is used
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/usr/bin/code-server", "--bind-addr", "0.0.0.0:8888", "--auth", "none", "--disable-telemetry", "/workspace"]
