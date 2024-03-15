#!/bin/bash

# Check database is ready
until nc -z -v -w 1 "${MYSQL_HOST}" "${MYSQL_PORT}"; do
    echo "Waiting for MySQL to be ready..."
    sleep 1
done

sleep 10

# Install dependencies
composer install --ignore-platform-reqs

# Run migrations
php bin/console doctrine:migrations:migrate --no-interaction

# Check migration status
migration_output=$(php bin/console doctrine:migrations:status)

# Check if migration status is not correct
if echo "$migration_output" | grep -q "Next.*Already at latest version"; then
    echo "Migration is completed"
else
    echo "Migration is not completed"
    exit 1
fi