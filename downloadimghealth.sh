#!/bin/bash
#TAG=2018.1.1.642.0

#
# Parameters
#
IMAGE=irishealth
TAG=intersystemsdc/irisdemo-base-irishealthint-community:$IMAGE.2019.1.0-stable
QUAYTAG=2019.1.0S.111.0

function dockerLogin() {
    printf "\n\nDocker Credentials:\n"
    printf "\n\tLogin   : "
    read dockerUsername
    printf "\tPassword: "
    stty -echo
    read dockerPassword
    stty echo
    printf "\n\n"

    if [ -z "$dockerUsername" ]
    then
        printfR "\n\nABORTING: Docker username is required.\n\n"
        exit 1
    fi

    if [ -z "$dockerPassword" ]
    then
        printfR "\n\nABORTING: Docker password is required\n\n"
        exit 1
    fi

    printf "\n\nLogging in...\n"
    if [ -z "$1" ]
    then
        printf "\n\nTrying to log in on docker hub...\n"
        docker login -u $dockerUsername -p $dockerPassword
    else
        printf "\n\nTrying to log in on $1...\n"
        docker login -u $dockerUsername -p $dockerPassword $1
    fi
    
    if [ $? -eq 0 ]; then 
        printf "\nLogin successful.\n"
    else
        printfR "\nLogin failed. \n"
        exit 1
    fi
}

printf "\n\nLoggin into docker.iscinternal.com (VPN Required!) to download newer images...\n"
dockerLogin docker.iscinternal.com

printf "\n\nPulling image...\n"
docker pull docker.iscinternal.com/intersystems/$IMAGE:$QUAYTAG
if [ $? -eq 0 ]; then 
    printf "\nPull of docker.iscinternal.com/intersystems/$IMAGE:$QUAYTAG succesful. \n"
else
    printf "\nPull of docker.iscinternal.com/intersystems/$IMAGE:$QUAYTAG failed. \n"
    exit 0
fi

printf "\n\nEnter with your credentials on docker hub so we can upload the images:\n"
dockerLogin

printf "\n\Tagging images...\n"
docker tag docker.iscinternal.com/intersystems/$IMAGE:$QUAYTAG $TAG
if [ $? -eq 0 ]; then 
    printf "\Tagging of docker.iscinternal.com/intersystems/$IMAGE:$QUAYTAG as $TAG successful\n"
else
    printfR "\Tagging of docker.iscinternal.com/intersystems/$IMAGE:$QUAYTAG as $TAG failed\n"
    exit 0
fi

printf "\n\Uploading images...\n"
docker push $TAG
if [ $? -eq 0 ]; then 
    printf "\Pushing of $TAG successful.\n"
else
    printfR "\Pushing of $TAG successful.\n"
    exit 0
fi