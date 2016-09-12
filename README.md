# creator-docker
Docker environment for building Creator images, packages and projects.

##Installing docker

To install docker on your host machine, follow the instructions given [here](https://docs.docker.com/engine/installation)

##Getting started

 * Sign up for a GitHub account

 * Install Git:  ```` sudo apt-get install git ````

 * Clone the repository: ```` git clone https://github.com/CreatorDev/creator-docker.git ````

##Building the Creator docker image

    cd creator-docker/

    docker build -t creator .

##Running the container

    docker run -it creator /bin/bash
