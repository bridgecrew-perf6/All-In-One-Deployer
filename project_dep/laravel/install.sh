#!/bin/bash

path=$1

cd $path
cp .env.example .env
composer install --no-cache
php artisan migrate --seed
php artisan storage:link
php artisan cache:clear
chown -R $USER:www-data storage
chown -R $USER:www-data bootstrap/cache

chmod -R 775 storage
chmod -R 775 bootstrap/cache

composer dump-autoload

npm install
npm run production