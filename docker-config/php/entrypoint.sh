#!/bin/bash

# Set proper permissions for Laravel storage, cache, and database directories
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/www/database
chmod -R 775 /var/www/storage /var/www/bootstrap/cache /var/www/database

# Execute the original command
exec "$@"
