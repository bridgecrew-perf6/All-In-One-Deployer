#!/bin/bash

GIT_URL=$1
DEPLOY_PATH=$2
APP_NAME=$3
BRANCH=$4

# add git repo to known_hosts
if [[ "$GIT_URL" =~ .*"gitlab".* ]]; then
    echo "Add Gitlab to known_hosts"
    ssh-keyscan -t rsa github.com | tee github-key-temp | ssh-keygen -lf -
elif [[ "$GIT_URL" =~ .*"github".* ]]; then
    echo "Add Github to known_hosts"
    ssh-keyscan -t rsa github.com | tee github-key-temp | ssh-keygen -lf -
fi

# clone project into folder
git clone $GIT_URL ${DEPLOY_PATH}/${APP_NAME} -b $BRANCH
