#!/bin/bash

# variables
dbuser=$1
dbpass=$2
dbname=$3
echo "DB Username: ${dbuser}"
echo "DB Pass: ${dbpass}"
echo "DB Name: ${dbname}"

# install postgresql
sudo apt update
sudo apt install postgresql postgresql-contrib -y
sudo -u postgres bash -c "psql -c \"CREATE DATABASE ${dbname};\""
sudo -u postgres bash -c "psql -c \"CREATE USER ${dbuser} WITH PASSWORD '${dbpass}';\""
sudo -u postgres bash -c "psql -c \"ALTER ROLE ${dbuser} SET client_encoding TO 'utf8';\""
sudo -u postgres bash -c "psql -c \"ALTER ROLE ${dbuser} SET default_transaction_isolation TO 'read committed';\""
sudo -u postgres bash -c "psql -c \"ALTER ROLE ${dbuser} SET timezone TO 'ASIA/Kuala_Lumpur';\""
sudo -u postgres bash -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE ${dbname} TO ${dbuser};\""