#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker buildx build --platform linux/arm64 -f ./arm64.dockerfile -t ${DOCKER_REPO}:arm64-version-${VERSION} .

docker tag ${DOCKER_REPO}:arm64-version-${VERSION} ${DOCKER_REPO}:arm64-latest