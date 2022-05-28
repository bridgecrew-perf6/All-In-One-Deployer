#!/bin/bash

language=$1
version=$2

# install nginx
sudo apt update -y
if [ -e /var/run/apache2/apache2.pid ]; then
    echo "Apache is installed and running";
else
    sudo apt install apache2 libapache2-mod-$language$version -y
    sudo systemctl enable apache2
fi