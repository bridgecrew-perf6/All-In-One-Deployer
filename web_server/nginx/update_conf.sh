#!/bin/bash

APP_NAME=$1
HOSTS=$2
VERSION=$3
DEPLOY_PATH=$4
# DEPLOY_PATH=%2Fvar%2Fwww

sudo systemctl stop nginx

sed -i "s/PROJECT/$APP_NAME/g" /etc/nginx/sites-available/$APP_NAME
sed -i "s/DOMAIN/$HOSTS/g" /etc/nginx/sites-available/$APP_NAME
sed -i "s/PHPVERSION/$VERSION/g" /etc/nginx/sites-available/$APP_NAME
sed -i "s|DEPLOY_PATH|$DEPLOY_PATH|g" /etc/nginx/sites-available/$APP_NAME

rm -rf /etc/nginx/sites-enabled/*
ln -s /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enabled/$APP_NAME

lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill

sudo systemctl start nginx
