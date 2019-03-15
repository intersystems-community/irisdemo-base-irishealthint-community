#!/bin/bash
#
# Amir Samary - 2018
#
# All this script does is to run the Installer Manifest on class IRISConfig.Installer.
# The class will be run on %SYS namespace as it should be. The user name and password used to load
# the installer class and run it must be specified on environment variables
# IRIS_USERNAME and IRIS_PASSWORD.

# This must not be used on production. This is a work around to have journaling working when
# working on Mac
# printf "\nAdding configuration to iris.cpf so that Journaling will be enabled when running on non-linux platform (Mac)..."
# cat /usr/irissys/iris.cpf | grep usedirectio
# if [ $? -eq 1 ]
# then
#     printf "\n\tAdding ausedirectio=-1 to iris.cpf...\n"
#     sed -i '/\[config\]/ausedirectio=-1' /usr/irissys/iris.cpf
# else
#     printf "\n\tausedirectio=-1 is already there.\n"
# fi

# From now on, any error should interrupt the script
set -e

printf "\n Configuring alternate journal directory..."
sed -i "s/AlternateDirectory=.*/AlternateDirectory=\/usr\/irissys\/mgr\/journal2\//" /usr/irissys/iris.cpf
mkdir /usr/irissys/mgr/journal2/ 
chown root:irisusr /usr/irissys/mgr/journal2
chmod g+w /usr/irissys/mgr/journal2

printf "\nLoading base installer...\n"

iris start iris

VerifySC='If $System.Status.IsError(tSC) { Do $System.Status.DisplayError(tSC) Do $zu(4,$j,1) } Else { Do $zu(4,$j,0) }'

# This specific command may fail on images that are based on this because I don't expect to find IRISDemo.InstallerBase 
# on the developer's project (they should not override this class on their projects!)
# That is why we are not checking the status code.
printf "%s\n%s\nzn \"%s\"\nSet tSC=\$system.OBJ.Load(\"%s\",\"ck\")\n" "$IRIS_USERNAME" "$IRIS_PASSWORD" "%SYS" "/tmp/iris_project/IRISConfig/InstallerBase.cls" | irissession IRIS

# PARTIAL CLEANING UP ---------------------------------------------------------------------------------
#
# We should be using /usr/irissys/dev/Container/imageBuildSteps.sh to to the clean up.
# But one of the things that this script does is reseting the iris password. 
# As this base image is to be used as the basis for our demos, we want the password to be always
# the same (SuperUser/sys). So we will not be using this script. Instead, we will be doing most of
# what the script does here on our own script (except resetting the password)

printf "\n\nCleaning up..."
printf "%s\n%s\n%s\n%s\n%s\n%s\n" "$IRIS_USERNAME" "$IRIS_PASSWORD" "zn \"%SYS\"" "do INT^JRNSTOP" "kill ^%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") Halt" | irissession IRIS

iris stop iris quietly

rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/*
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log

# CLEANING UP COMPLETE ------------------------------------------------------------------------
