#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker build -f ./Dockerfile.x86 -t ${DOCKER_REPO}:version-${VERSION} .