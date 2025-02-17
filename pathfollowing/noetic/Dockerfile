# enviroment desktop
# created by Markus Bader <markus.bader@tuwien.ac.at>

ARG ROS_DISTRO=noetic
ARG OWNER=tuwrobotics
ARG BASE_CONTAINER=$OWNER/tuw-${ROS_DISTRO}-ide
FROM $BASE_CONTAINER

USER root


RUN apt-get update
RUN apt-get -y dist-upgrade

RUN apt-get install -y \
    ros-${ROS_DISTRO}-gmapping \
	ros-${ROS_DISTRO}-amcl  \
	ros-${ROS_DISTRO}-map-server  \
	ros-${ROS_DISTRO}-move-base  \
	ros-${ROS_DISTRO}-navigation  \
	ros-${ROS_DISTRO}-rviz \
    ros-${ROS_DISTRO}-laser-filters \
	ros-${ROS_DISTRO}-teleop-twist-keyboard \
	ros-${ROS_DISTRO}-joy \
	ros-${ROS_DISTRO}-joy-teleop \
	ros-${ROS_DISTRO}-urg-node 
    
RUN apt-get install -y \
    libdxflib-dev \
    libncurses5-dev \
    qtbase5-dev \
    libaria-dev
    
USER ${MY_USER}
ENV MY_PRJ=${MY_HOME}/projects/ros/pathfollowing/
RUN mkdir -p ${MY_PRJ}


COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws/src ${MY_PRJ}/src
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${MY_PRJ}; catkin_make'

RUN echo 'if [ -f "env.sh" ]; then\n source env.sh \nelse\n echo "no env.sh to source" \nfi' >> ~/.bashrc

RUN touch ${MY_PRJ}/env.sh && \  
    chmod +x ${MY_PRJ}/env.sh && \
    echo 'source /opt/ros/noetic/setup.bash' >> ${MY_PRJ}/env.sh  && \   
    echo 'echo "** ROS /opt/ros/noetic/setup.bash initialized **"' >> ${MY_PRJ}/env.sh  && \   
    echo 'source $HOME/projects/ros/pathfollowing/devel/setup.bash' >> ${MY_PRJ}/env.sh


RUN echo 'roslaunch tuw_gazebo_models robot_in_world.launch motor_plugin:=diff_iws launch_ground_truth_robot_state_publisher:=false' >> ~/.bash_history  && \   
    echo 'export ROS_MASTER_URI=http://ralf:11311/' >> ~/.bash_history && \     
    echo 'export ROS_MASTER_URI=http://r0:11311/' >> ~/.bash_history && \     
    echo 'roslaunch tuw_launches pathfollowing.launch' >> ~/.bash_history && \     
    echo 'roslaunch tuw_launches rviz_pathfollowing.launch' >> ~/.bash_history  && \   
    echo 'roslaunch tuw_launches laser_filter.launch robot_name:=r0' >> ~/.bash_history  && \  
    echo 'roslaunch tuw_launches robot_description.launch' >> ~/.bash_history  && \  
    echo 'tmux new -s pathfollowing \; split-window -v \; select-pane -t 1 \; split-window -v \; select-pane -t 0 \; attach' >> ~/.bash_history

COPY --chown=${MY_USER}:${MY_USER} ./pathfollowing.md ${MY_PRJ}/info.md
USER root

USER ${MY_USER}
WORKDIR ${MY_PRJ}
ENV HOME=${MY_HOME}
CMD /bin/bash
