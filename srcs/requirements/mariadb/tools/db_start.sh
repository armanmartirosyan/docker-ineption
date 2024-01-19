#!/bin/bash

service mysql start 

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > db.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASS' ;" >> db.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql < db.sql

sleep 2
kill $(cat /var/run/mysqld/mysqld.pid)

mysqld