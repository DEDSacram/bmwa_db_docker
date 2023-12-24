FROM mariadb:latest

# Install mariadb client
RUN apt-get update && \
    apt-get install -y mariadb-client

# Create a directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy the database data SQL dump to the initialization scripts directory
COPY mysql-data.sql /docker-entrypoint-initdb.d/

# Create an initialization script
RUN echo -e '#!/bin/bash\n\
\n\
# Wait for MariaDB to be ready\n\
until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e ";" ; do\n\
  echo "Waiting for MariaDB to be ready..."\n\
  sleep 1\n\
done\n\
\n\
# Create a new database\n\
mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS bmwa;"\n\
\n\
# Use the newly created database\n\
mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "USE bmwa;"\n\
\n\
# Import data into the database\n\
mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" bmwa < /docker-entrypoint-initdb.d/mysql-data.sql' > /docker-entrypoint-initdb.d/init.sh

# Grant execute permissions to the initialization script
RUN chmod +x /docker-entrypoint-initdb.d/init.sh


