
IMAGE_NAME?=intersystemsdc/irisdemo-base-irishealthint-community:2019.3-1
IRIS_PROJECT_FOLDER_NAME?=irishealthdemoint-atelier-project

build:
	docker build --build-arg IRIS_PROJECT_FOLDER_NAME=$(IRIS_PROJECT_FOLDER_NAME) -t $(IMAGE_NAME) . 

push:
	docker push $(IMAGE_NAME)