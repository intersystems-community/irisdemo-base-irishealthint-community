#!/bin/bash

IMAGE_NAME=intersystemsdc/irisdemo-base-irishealthint-community:2019.1.0-released-community

IRIS_PROJECT_FOLDER_NAME=irisdemo-base-irishealthint-community-atelier-project

docker build --build-arg IRIS_PROJECT_FOLDER_NAME=$IRIS_PROJECT_FOLDER_NAME -t $IMAGE_NAME . 