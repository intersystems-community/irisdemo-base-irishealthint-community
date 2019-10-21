@ECHO OFF

set IRIS_PROJECT_FOLDER_NAME=irishealthdemoint-atelier-project
set GIT_REPO_NAME=irisdemo-base-irishealthint-community
set TAG=2019.3-latest
set IMAGE_NAME=intersystemsdc/%GIT_REPO_NAME%:%TAG%

docker build --squash --build-arg IRIS_PROJECT_FOLDER_NAME=%IRIS_PROJECT_FOLDER_NAME% --force-rm -t %IMAGE_NAME% .