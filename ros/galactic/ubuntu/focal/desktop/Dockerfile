# ros2 desktop
# created by Markus Bader <markus.bader@tuwien.ac.at>
# based on the https://github.com/osrf/docker_images

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG BASE_CONTAINER=$OWNER/galactic-base
FROM $BASE_CONTAINER

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-galactic-desktop=0.9.3-2* \
    && rm -rf /var/lib/apt/lists/*

