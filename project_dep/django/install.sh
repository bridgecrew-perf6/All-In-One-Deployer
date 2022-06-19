#!/bin/bash

path=$1
nodejs=$2

cd $path

virtualenv $path/environ
source $path/environ/bin/activate
pip install gunicorn
pip install -r requirements.txt

$path/manage.py makemigrations
$path/manage.py migrate
$path/manage.py collectstatic

# to do: create superuser

deactivate

if [ "$nodejs" = "YES" ]
    then
        npm install
        npm run production
fi
