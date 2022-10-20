#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker buildx use default

docker buildx build --platform linux/arm64 -t ${DOCKER_REPO}:arm64-version-${VERSION} -f ./arm64.dockerfile .

docker tag ${DOCKER_REPO}:arm64-version-${VERSION} ${DOCKER_REPO}:arm64-latest