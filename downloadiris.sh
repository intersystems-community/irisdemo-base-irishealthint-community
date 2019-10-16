#!/bin/bash
#
# This script is no longer necessary now that IRIS for Health Community 2019.3 is 
# publicly available on the Docker Store.
#
# Before that, we would have to pull it from our internal docker registry and
# push it to our private docker registry repo.

#
# Parameter
#
TAG=2019.3.0.308.0

#
# Constants
#
ISC_IMAGENAME=store/intersystems/irishealth:$TAG-community
DH_IMAGENAME=intersystemsdc/irisdemo-base-irishealthint-community:irishealth.$TAG-community

# printf "\nDeleting old images...\n"

# docker images | grep $OLDTAG | awk '{print $3}' | xargs docker rmi -f

# printf "\nOld images deleted.\n"

printf "\n\nLoggin into docker.iscinternal.com (VPN Required!) to download newer images...\n"
docker login docker.iscinternal.com

printf "\n\nPulling images...\n"
docker pull $ISC_IMAGENAME
if [ $? -eq 0 ]; then
    printf "\nPull of $ISC_IMAGENAME succesful. \n"
else
    printf "\nPull of $ISC_IMAGENAME failed. \n"
    exit 0
fi

printf "\n\Tagging images...\n"
docker tag $ISC_IMAGENAME $DH_IMAGENAME

if [ $? -eq 0 ]; then
    printf "\Tagging of $ISC_IMAGENAME as $DH_IMAGENAME successful\n"
else
    printf "\Tagging of $ISC_IMAGENAME as $DH_IMAGENAME failed\n"
    exit 0
fi

printf "\n\nEnter with your credentials on docker hub so we can upload the images:\n"
docker login

printf "\n\Uploading images...\n"
docker push $DH_IMAGENAME
if [ $? -eq 0 ]; then
    printf "\Pushing of $DH_IMAGENAME successful.\n"
else
    printf "\Pushing of $DH_IMAGENAME successful.\n"
    exit 0
fi