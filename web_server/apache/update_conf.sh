#!/bin/bash

APP_NAME=$1
HOSTS=$2
VERSION=$3
DEPLOY_PATH=$4
# DEPLOY_PATH=%2Fvar%2Fwww

sudo systemctl stop apache2

sed -i "s/PROJECT/$APP_NAME/g" /etc/apache2/sites-available/$APP_NAME
sed -i "s/DOMAIN/$HOSTS/g" /etc/apache2/sites-available/$APP_NAME
sed -i "s/PHPVERSION/$VERSION/g" /etc/apache2/sites-available/$APP_NAME
sed -i "s|DEPLOY_PATH|$DEPLOY_PATH|g" /etc/apache2/sites-available/$APP_NAME

rm -rf /etc/apache2/sites-enabled/*
ln -s /etc/apache2/sites-available/$APP_NAME /etc/apache2/sites-enabled/$APP_NAME

lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill

sudo systemctl start apache2
