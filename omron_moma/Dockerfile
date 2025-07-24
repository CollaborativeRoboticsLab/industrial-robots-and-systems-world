# ------------------------------------------------------------------------------------------------------------------------
# Base stage: Build workspace with required ROS 2 packages, MoveIt, and Nav2
# ------------------------------------------------------------------------------------------------------------------------
FROM ros:humble-ros-base-jammy AS base

# Environment
ENV DEBIAN_FRONTEND=noninteractive
ENV WORKSPACE_ROOT=/omron_ws

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-dev \
    build-essential \
    curl \
    lsb-release \
    wget \
    gnupg2 \
    qtdeclarative5-dev \
    libqt5widgets5 \
    ros-humble-moveit \
    ros-humble-controller-manager \
    ros-humble-joint-trajectory-controller \
    ros-humble-joint-state-broadcaster \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    ros-humble-vision-opencv \
    ros-humble-rviz2 \
    ros-humble-nav2-bringup \
    ros-humble-navigation2 \
    ros-humble-nav2-simple-commander \
    ros-humble-tf2-tools \
    ros-humble-turtlebot3-msgs \
    ros-humble-turtlebot3-navigation2 \
    libx11-dev \
    libxext-dev \
    libxtst-dev \
    libxrender-dev \
    libxrandr-dev \
    libgl1-mesa-glx \
    libglu1-mesa \
    libxi-dev \
    libsm6 \
    libxkbcommon-x11-0 \
    x11-xserver-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create workspace and clone source
WORKDIR ${WORKSPACE_ROOT}/src

RUN git clone https://github.com/CollaborativeRoboticsLab/Omron_MoMa_ROS2.git && \
    git clone https://github.com/CollaborativeRoboticsLab/Omron_AMR_ROS2.git && \
    git clone https://github.com/CollaborativeRoboticsLab/Omron_TM_ROS2.git && \
    git clone https://github.com/CollaborativeRoboticsLab/tmr_ros2.git

WORKDIR ${WORKSPACE_ROOT}

# Source ROS setup and build workspace
RUN . /opt/ros/humble/setup.sh && colcon build

# Clean up
RUN rm -rf ${WORKSPACE_ROOT}/src \
           ${WORKSPACE_ROOT}/log \
           ${WORKSPACE_ROOT}/build \
           /tmp/* \
           /var/lib/apt/lists/*

# ------------------------------------------------------------------------------------------------------------------------
# Final stage: Minimal runtime image with built workspace and GUI support
# ------------------------------------------------------------------------------------------------------------------------
FROM ros:humble-ros-base-jammy AS final

ENV WORKSPACE_ROOT=/omron_ws
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

# Copy built workspace from base stage
COPY --from=base / /

# Optional: custom entrypoint (make sure this script exists)
COPY /workspace_entrypoint.sh /workspace_entrypoint.sh

RUN chmod +x /workspace_entrypoint.sh

# GUI environment
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1

WORKDIR ${WORKSPACE_ROOT}

# Entry point
ENTRYPOINT ["/workspace_entrypoint.sh"]