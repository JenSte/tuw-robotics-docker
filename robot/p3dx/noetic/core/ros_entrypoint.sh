#!/bin/bash
#script to run with a host network
#export ROS_MASTER_URI=http://$(hostname --ip-address):11311
#export ROS_HOSTNAME=$(hostname --ip-address)
# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "${PRJ_DIR}/devel/setup.bash"
roslaunch tuw_p3dx aria_twist.launch &
roslaunch tuw_p3dx laser_hokuyo.launch

