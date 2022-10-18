#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker push ${DOCKER_REPO}:amd64-version-${VERSION}
docker push ${DOCKER_REPO}:amd64-latest
