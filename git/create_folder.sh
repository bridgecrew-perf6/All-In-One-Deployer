#!/bin/bash

DEPLOY_PATH=$1
APP_NAME=$2
REMOTEACCOUNT=$3

# delete nginx generated folder
echo "Delete html folder"
rm -rf html

### Check if a directory does not exist ###
if [ ! -d "${DEPLOY_PATH}/${APP_NAME}" ]
then
    echo "Create folder"
    mkdir -p "${DEPLOY_PATH}/${APP_NAME}"
fi

echo "Change owner of the folder"
chown -Rf ${REMOTEACCOUNT}:www-data ${DEPLOY_PATH}/${APP_NAME}
