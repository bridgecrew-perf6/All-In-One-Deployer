#!/bin/bash

# install php
sudo add-apt-repository ppa:ondrej/php
sudo add-apt-repository ppa:ondrej/apache2
sudo add-apt-repository ppa:ondrej/nginx
sudo apt-get update -y
sudo apt install php8.1 -y
sudo apt install php8.1-{bcmath,xml,fpm,zip,intl,gd,cli,bz2,curl,mbstring,pgsql,opcache,soap,cgi,snmp,memcached,mcrypt,simplexml,dom,pdo,tokenizer} -y
sudo apt install php-json -y

