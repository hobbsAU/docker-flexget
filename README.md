# docker-flexget [![Docker Pulls](https://img.shields.io/docker/pulls/hobbsau/docker-flexget.svg)](https://hub.docker.com/r/hobbsau/docker-flexget/)

Run flexget from a docker container

## Install
```sh
docker pull hobbsau/flexget
```

## Usage

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
