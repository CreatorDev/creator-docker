# creator-docker
Docker environment for building Creator images, packages and projects.

##To build the docker image

    docker build -t <tag> <docker_file_directory>

i.e. if current working directory is the folder with the docker file

    docker build -t creator .

##Running the container:

    docker run -it creator /bin/bash
