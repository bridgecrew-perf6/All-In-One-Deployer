#!/bin/bash

GIT_URL=$1
DEPLOY_PATH=$2
APP_NAME=$3
BRANCH=$4

# add git repo to known_hosts
if [[ ! -f  ~/.ssh/known_hosts ]]; then
    echo "Create known hosts file"
    mkdir -p ~/.ssh
    touch ~/.ssh/known_hosts
fi

if [[ "$GIT_URL" =~ .*"gitlab".* ]]; then
    egrep "^gitlab" ~/.ssh/known_hosts >/dev/null
	if [ ! $? -eq 0 ]; then
        echo "Add Gitlab to known_hosts"
        ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
    fi
elif [[ "$GIT_URL" =~ .*"github".* ]]; then
    egrep "^github" ~/.ssh/known_hosts >/dev/null
        if [ ! $? -eq 0 ]; then
        echo "Add Github to known_hosts"
        ssh-keyscan github.com >> ~/.ssh/known_hosts
    fi
fi

if [[ ! -f  ~/.ssh/id_rsa ]]; then
    echo "Create keygen"
    # ssh-keygen -t rsa -b 2048 -q -P ""
    ssh-keygen -t rsa -b 2048 -P "" -f ~/.ssh/id_rsa
fi

sleep 5
echo "----------------------------------------------------------------"
cat ~/.ssh/id_rsa.pub
echo "Copy id_rsa.pub into your git repository. Script will wait for 60 seconds"
echo "----------------------------------------------------------------"
sleep 60

# clone project into folder
git clone $GIT_URL ${DEPLOY_PATH}/${APP_NAME} -b $BRANCH
