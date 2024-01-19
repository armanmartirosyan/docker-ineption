#!/bin/bash

mkdir -p /var/www/html
cd /var/www/html

if [ -f ./wp-config.php ]; then
	echo "Wordpress download already done."
else

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# Wordpress  configs
	sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
	sed -i "s/password_here/$DB_USER_PASS/g" wp-config-sample.php
	sed -i "s/localhost/$DB_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	# ADMIN && USER 
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
	wp plugin update --all --allow-root
	wp plugin install redis-cache --activate --allow-root

	## redis ##

	wp config set WP_REDIS_HOST $REDIS_HOSTNAME --allow-root
    wp config set WP_REDIS_PORT $REDIS_PORT --raw --allow-root
    wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
    wp config set WP_REDIS_PASSWORD $REDIS_PASS --allow-root
    wp config set WP_REDIS_CLIENT phpredis --allow-root

fi

chmod 777 wp-content/ wp-content/plugins/  wp-content/themes/ wp-content/uploads/ 
chown -R www-data:www-data /var/www/html
wp plugin activate redis-cache --allow-root

exec $@