#!/bin/bash

# Check if .env file exists, if not copy from .env.example
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Generate application key if not set
if ! grep -q "APP_KEY=base64" .env; then
    php artisan key:generate
fi

# Run migrations, ignore errors if tables exist
php artisan migrate --force --no-interaction || true

# Start PHP-FPM
php-fpm

