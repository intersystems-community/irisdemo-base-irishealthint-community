#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker buildx build  --platform linux/amd64 -f ./amd64.dockerfile -t ${DOCKER_REPO}:amd64-version-${VERSION} .

docker tag ${DOCKER_REPO}:amd64-version-${VERSION} ${DOCKER_REPO}:amd64-latest