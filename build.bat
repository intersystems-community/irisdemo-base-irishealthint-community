@ECHO OFF

SET DOCKER_REPO=intersystemsdc/irisdemo-base-irishealthint-community
set /p VERSION=<VERSION
set PWD=%~dp0

echo
docker build -t %DOCKER_REPO%:version-%VERSION% .
