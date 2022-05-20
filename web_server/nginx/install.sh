#!/bin/bash

# install nginx
sudo apt update -y
if [ -e /var/run/nginx.pid ]; then
    echo "nginx is running";
else
    sudo apt install nginx php8.1-fpm -y
    sudo systemctl enable nginx
fi