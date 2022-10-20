#!/bin/bash
# Delete all containers
docker rm -f local-registry
docker rm $(docker ps -a -q)
# Delete all images
docker rmi -f $(docker images -q)
docker system prune -a -f
docker run --privileged --pid=host docker/desktop-reclaim-space
