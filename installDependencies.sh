#!/bin/bash

# variables
# username=$1
# password=$2
# project=$3
# dbuser=$4
# dbpass=$5
# dbname=$6
# echo "Username: ${username}"
# echo "Password: ${password}"
# echo "Project: ${project}"
# echo "DB Username: ${dbuser}"
# echo "DB Pass: ${dbpass}"
# echo "DB Name: ${dbname}"

# install nginx
sudo apt update -y
# sudo apt upgrade -y
sudo apt install -y ca-certificates apt-transport-https software-properties-common
# sudo apt upgrade -y
# sudo apt update -y
# sudo apt install nginx -y

# # install php
# sudo apt install php8.1-fpm -y
# sudo apt install -y php8.1-snmp php-memcached php8.1-pgsql php8.1-mcrypt php8.1-curl php8.1-cli  php8.1-gd php8.1-simplexml php8.1-dom php8.1-mbstring
# sudo apt install -y php8.1-mbstring php8.1-cli php8.1-bcmath php-json php8.1-xml php8.1-zip php8.1-pdo php8.1-common php8.1-tokenizer php-curl php-xml

# # install postgresql
# sudo apt update
# sudo apt install postgresql postgresql-contrib -y
# sudo -u postgres bash -c "psql -c \"CREATE DATABASE ${dbname};\""
# sudo -u postgres bash -c "psql -c \"CREATE USER ${dbuser} WITH PASSWORD '${dbpass}';\""
# sudo -u postgres bash -c "psql -c \"ALTER ROLE ${dbuser} SET client_encoding TO 'utf8';\""
# sudo -u postgres bash -c "psql -c \"ALTER ROLE ${dbuser} SET default_transaction_isolation TO 'read committed';\""
# sudo -u postgres bash -c "psql -c \"ALTER ROLE ${dbuser} SET timezone TO 'ASIA/Kuala_Lumpur';\""
# sudo -u postgres bash -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE ${dbname} TO ${dbuser};\""

# # install composer
# sudo apt update
# sudo apt install php-cli unzip
# cd ~
# curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
# sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
# composer

# create project folder
# sudo mkdir -p /var/www/${project}
# cd /var/www/
# sudo chown ${username}:www-data ${project}
# ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# git clone git@gitlab.com:jps-malaysia/spaqs.git ${project}/