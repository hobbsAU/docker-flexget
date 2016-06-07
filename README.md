# docker-flexget [![Docker Pulls](https://img.shields.io/docker/pulls/hobbsau/flexget.svg)](https://hub.docker.com/r/hobbsau/flexget/)

Run flexget from a docker container

Key features of this repository:
* Efficiency - image is small <50MB
* Security - process runs inside the container as regular user and so does the docker image with the USER directive
* Management - make script allows for easy configuration and ongoing maintenance


## Prerequisites
To use this package you must ensure the following:
* Linux host system configured with a working Docker installation
* make installed (optional for management script)
* git installed (optional for src and management script)


## Installation - including management scripts and src
```sh
        git clone https://github.com/hobbsAU/docker-flexget.git
        cd docker-flexget
        make run
```

## Installation - standalone Docker image
```sh
docker pull hobbsau/flexget
```

## Usage - using management scripts

### Creating and running the container
```sh
$ make run
```

### Stopping a running container
```sh
$ make stop
```

### Starting a stopped container
```sh
$ make start
```

### Destroying (deleting) a running or stopped container
```sh
$ make clean
```

### Remotely trigger a container rebuild
```sh
$ make build
```


## Usage - standalone Docker image

First let's setup the data container that will map the config directory from the host to the container as well as the output directory. This container will provide persistent storage.
```sh
$ docker create \
 --name flexget-data \
 -v <hostdir>:/config \
 -v <hostdir>:/mnt \
 hobbsau/flexget \
 /bin/true
```  

Example using my host and the /srv/flexget location on my host:
```sh
$ sudo docker create --name flexget-data -v /srv/flexget/config:/config -v /srv/flexget/mnt:/mnt hobbsau/flexget
```  

Next we run the flexget-service and this will automatically map the volumes within the new container.
```sh
$ docker run -d \
 --restart=always \
 --volumes-from flexget-data \
 --name flexget-service \
 hobbsau/flexget
```  

You should see two new containers in the docker listing:
```sh
$ docker ps -a
```

## Developing
The [source repo](https://github.com/hobbsAU/docker-flexget) is linked to dockerhub using autobuild. Any push to this repo will auto-update the docker image on docker hub.
