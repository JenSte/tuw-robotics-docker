# Docker Containers

This repository contains the Dockerfiles and according scripts for the tuw_docker images.

<img src="./uml-container.draw.io.svg" height="300">

## Containers
Check out the `README.md` for the container you are interested in.
The base container is designed to work either for ROS1 or ROS2 and has some basic tools  installed.
Other containers are build with the base container.

* ROS1+2 base system [tuw_docker:tuw_noetic_base or tuw_docker:tuw_galactic_base](./base/):
* TUW Gazebo [tuw:gazebo](./gazebo/)
* Independent Wheel Offset Steering (IWOS) [tuw:iwos](./iwos/)
* Mobile Robotics Framework [mobile_robotics](./mobile_robotics)
* Multi Robot Route Planner Framework [tuw_multi_robot](./tuw_multi_robot/mrrp/)
* TUW ROS1_Bridge [tuw-ros1-bridge](./ros)

### robot System
Select your container you like to build and check the related Readme.md

* [robot-iwos](./iwos/robot-iwos/Readme.md)

### ROS1_Bridge
The [tuw-ros1-bridge](./ros/galactic/ubuntu/focal/tuw-bridge/Readme.md) container allows communication between ROS1 and ROS2 nodes using the messages defined in the [tuw_msgs](https://github.com/tuw-robotics/tuw_msgs) repository.

## Useful commands and operations for Docker

The following commands are useful for the operation of Docker and are generally applicable.

### Delete images

#### Delete a single image
To delete a image:
```bash
docker image rm <image_name>
```

#### Delete all images
To delete all images:
```bash
docker image rm -f $(docker images -a -q)
```
To deleate images with <none> TAG

```
docker rmi $(docker images -f "dangling=true" -q)
```

### Delete container

#### Delete a singe container
To delete a container run:
```bash
docker container rm <container_name>
```
When the container is still running stop the container before deleting:
```bash
docker container stop <container_name>
```
Alternatively the process of deleting can be forced:
```bash
docker container rm -f <container_name>
```

#### Delete all stopped containers
To delete all stopped containers:
```bash
docker container rm $(docker container ls -a -q -f status=exited)
```

### Pushing an image to DockerHub
[DockerHub](https://hub.docker.com/) is a registry for Docker images.
Firstly, you need a DockerHub account (create the account in the DockerHub webinterface).
Login to DockerHub in your shell:
```bash
docker login
```
Secondly, you need a repository in your DockerHub (create the repository in the DockerHub webinterface).
Thirdly, you need to tag the image in order to push it to DockerHub:
```bash
docker tag <repository>:<image_tag> <dockerhub_account_name>/<dockerhub_repository_name>:<image_tag>
```
Note: the default `repository` is `tuw_docker`.

Then you can push the image to DockerHub:
```bash
docker push <dockerhub_account_name>/<dockerhub_repository_name>:<image_tag>
```

After the image has been pushed to DockerHub it can be pulled with:
```bash
docker pull <dockerhub_account_name>/<dockerhub_repository_name>:<image_tag>
```

### Moving docker data container
```
sudo service docker stop
sudo vim /etc/docker/daemon.json 
```
```
{ 
   "data-root": "/path/to/your/docker" 
}
```
```
sudo rsync -aP /var/lib/docker/ /path/to/your/docker
sudo mv /var/lib/docker /var/lib/docker.old
sudo service docker start
# sudo rm -rf /var/lib/docker.old
```


