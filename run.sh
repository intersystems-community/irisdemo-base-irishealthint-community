#!/bin/bash
#

DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
VERSION=`cat ./VERSION`

printf "\n\nRunning container. "
printf "\n\t Management portal is on http://localhost:52773/csp/sys/UtilHome.csp"
printf "\n\t Simulator page is on http://localhost:52773/csp/appint/demo.csp"
printf "\n\t InterSystems IRIS Web Server Port is on 52773."
printf "\n\t InterSystems IRIS Super Server Port is on 51773."

docker run -it --init --rm \
    -p 51773:51773 -p 52773:52773 -p 1883:1883 \
    --name irishealth-community \
    ${DOCKER_REPO}:version-${VERSION}

printf "\nExited container\n"