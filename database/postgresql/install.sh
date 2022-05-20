#!/bin/bash

# variables
dbuser=\"${1}\"
dbpass=\'${2}\'
dbname=$3

# install postgresql
sudo apt update
sudo apt install postgresql postgresql-contrib -y

sudo su - postgres bash -c "psql -c \"CREATE DATABASE ${dbname};\""
sudo su - postgres bash -c "psql -c \"CREATE USER $(printf '%q' $dbuser) WITH PASSWORD ${dbpass};\""
sudo su - postgres bash -c "psql -c \"ALTER ROLE $(printf '%q' $dbuser) SET client_encoding TO 'utf8';\""
sudo su - postgres bash -c "psql -c \"ALTER ROLE $(printf '%q' $dbuser) SET default_transaction_isolation TO 'read committed';\""
sudo su - postgres bash -c "psql -c \"ALTER ROLE $(printf '%q' $dbuser) SET timezone TO 'ASIA/Kuala_Lumpur';\""
sudo su - postgres bash -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE ${dbname} TO $(printf '%q' $dbuser);\""
