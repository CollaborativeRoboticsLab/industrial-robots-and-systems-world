#!/bin/bash
set -e

# Source ROS environment
source /opt/ros/humble/setup.bash
source /omron_ws/install/setup.bash

exec "$@"