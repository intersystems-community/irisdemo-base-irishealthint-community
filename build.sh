#!/bin/bash

set -e

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

docker build -t ${DOCKER_REPO}:version-${VERSION} .