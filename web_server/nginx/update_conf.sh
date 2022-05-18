#!/bin/bash

APP_NAME=$1
HOSTS=$2
VERSION=$2

sed 's/${APP_NAME}/PROJECT/g' /etc/nginx/sites-available/$APP_NAME
sed 's/${HOSTS}/HOST/g' /etc/nginx/sites-available/$APP_NAME
sed 's/${VERSION}/PHPVERSION/g' /etc/nginx/sites-available/$APP_NAME

rm -rf /etc/nginx/sites-available/*
ln -s /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enable/$APP_NAME
