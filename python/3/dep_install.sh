#!/bin/bash

path=$1
nodejs=$2

cd $path

virtualenv $path/environ
source $path/bin/activate
pip install gunicorn
pip install -r requirement.txt

source $path/manage.py makemigrations
source $path/manage.py migrate
source $path/manage.py collectstatic

deactivate

if [ "$nodejs" = "YES" ]
    then
        npm install
        npm run production
fi
