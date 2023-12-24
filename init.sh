#!/bin/bash

# Wait for MariaDB to be ready
until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e ";" ; do
  echo 'Waiting for MariaDB to be ready...'
  sleep 1
done

# Create a new database
mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS bmwa;"

# Use the newly created database
mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "USE bmwa;"

# Import data into the database
mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" bmwa < /docker-entrypoint-initdb.d/mysql-data.sql
