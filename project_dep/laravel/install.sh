#!/bin/bash

path=$1

echo $path
cd $path
cp .env.example .env
composer install --no-cache
php artisan migrate --seed
php artisan storage:link
php artisan cache:clear
chmod -R 775 storage
chmod -R 775 bootstrap/cache
composer dump-autoload