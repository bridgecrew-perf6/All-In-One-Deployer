#!/bin/bash

language=$1
version=$2

# install nginx
sudo apt update -y
if [ -e /var/run/nginx.pid ]; then
    echo "Nginx is installed and running";
else
    sudo apt install nginx $language$version-fpm -y
    sudo systemctl enable nginx
fi