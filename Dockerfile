#FROM store/intersystems/irishealth:2019.3.0.308.0-community
FROM intersystemsdc/irisdemo-base-irishealthint-community:irishealth-community.2019.4.0.379.0

LABEL maintainer="Amir Samary <amir.samary@intersystems.com>"

# Get Java OpenJDK 1.8 for JDBC and/or Java Gateway, which must run as root user
USER root
RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Going back to irisowner now
USER irisowner

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

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
# The ADD command ignores the current USER and always add as root. 
# That is why were are doing the chown
ADD --chown=irisowner:irisuser ./${IRIS_PROJECT_FOLDER_NAME}/ $IRIS_APP_SOURCEDIR

# Adding scripts to load base image source and child image source
ADD ./imageBuildingUtils.sh $ISC_PACKAGE_INSTALLDIR/demo/imageBuildingUtils.sh
ADD ./irisdemobaseinstaller.sh $ISC_PACKAGE_INSTALLDIR/demo/irisdemobaseinstaller.sh
ADD ./irisdemoinstaller.sh $ISC_PACKAGE_INSTALLDIR/demo/irisdemoinstaller.sh

# This must be called only on this base images. Child images must call irisdemoinstaller.sh instead.
RUN $ISC_PACKAGE_INSTALLDIR/demo/irisdemobaseinstaller.sh

HEALTHCHECK --interval=5s CMD /irisHealth.sh || exit 1