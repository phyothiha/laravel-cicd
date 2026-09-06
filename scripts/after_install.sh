#!/usr/bin/env bash

set -euo pipefail

APP_DIR="/var/www/laravel"

cd "$APP_DIR"

if [ ! -f .env ]; then
    echo "ERROR: $APP_DIR/.env does not exist."
    exit 1
fi

mkdir -p \
    storage/framework/cache/data \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs \
    bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache
chmod -R ug+rwX storage bootstrap/cache

sudo -u www-data php artisan optimize:clear
sudo -u www-data php artisan optimize
sudo -u www-data php artisan migrate --force

systemctl restart php8.4-fpm

echo "Laravel deployment completed."
