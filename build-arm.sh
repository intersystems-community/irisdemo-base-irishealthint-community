#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker build -f ./Dockerfile.ARM -t ${DOCKER_REPO}:arm-version-${VERSION} .