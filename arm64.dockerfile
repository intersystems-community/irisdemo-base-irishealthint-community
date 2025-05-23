# FROM store/intersystems/irishealth-community:2020.1.0.209.0
# FROM intersystemsdc/irisdemo-base-irishealthint-community:irishealth-community.2021.2.0.619.0
# FROM intersystemsdc/irisdemo-base-irishealthint-community:irishealth-community.2021.2.0.649.0
# FROM containers.intersystems.com/intersystems/irishealth-community:2023.2.0.200.0-linux-arm64v8
FROM containers.intersystems.com/intersystems/irishealth-community:2025.1

# For some reason, on the ARM base image, the link from /bin/sh to /bin/dash is not there
# That causes all RUN commands below in the Dockerfile to fail. So instead of using /bin/sh
# as shell, I will change this to use /bin/bash.
# RUN ls -l /bin

LABEL maintainer="Amir Samary <amir.samary@intersystems.com>"

# Changing to root so we can add the files and then use the chown command to 
# change the permissions to irisowner/irisowner.
# Get Java OpenJDK 1.8 for JDBC and/or Java Gateway, which must run as root user
USER root

# Our base image brings a JVM already
#
# RUN apt-get -y update && \
#     apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/$(ls /usr/lib/jvm)

# Name of the project folder 
ARG IRIS_PROJECT_FOLDER_NAME=irishealthdemoint-atelier-project

# Used to specify a folder on the container with the source code (csp pages, classes, etc.)
# to load into the CSP application.
ENV IRIS_APP_SOURCEDIR=/tmp/iris_project/

# Name of the application. This will be used to define the namespace, database and 
# name of the CSP application of this application.
ENV IRIS_APP_NAME="APPINT"

# Default IRIS Global buffers and Routine Buffers
ENV IRIS_GLOBAL_BUFFERS=128
ENV IRIS_ROUTINE_BUFFERS=64

# Adding source code that will be loaded by the installer
# In order for the ADD command to add the files in the image with the correct user
# We need to be running the ADD command with the root user and use the --chown parameter
ADD ./${IRIS_PROJECT_FOLDER_NAME}/ $IRIS_APP_SOURCEDIR
RUN chown -R irisowner:irisowner $IRIS_APP_SOURCEDIR

# Adding scripts to load base image source and child image source
ADD ./imageBuildingUtils.sh /demo/imageBuildingUtils.sh
ADD ./irisdemobaseinstaller.sh /demo/irisdemobaseinstaller.sh
ADD ./irisdemoinstaller.sh /demo/irisdemoinstaller.sh
RUN chown -R irisowner:irisowner /demo

# Now we change back to irisowner so that the RUN command will be run with this user
USER irisowner

# This must be called only on this base images. Child images must call irisdemoinstaller.sh instead.
RUN /demo/irisdemobaseinstaller.sh

HEALTHCHECK --interval=5s CMD /irisHealth.sh || exit 1