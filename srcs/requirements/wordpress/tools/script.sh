#!/bin/bash

mkdir -p /var/www/html
cd			/var/www/html
chmod -R	775 /var/www/html;

chown -R	www-data /var/www/html;

sed -i		's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf
service		php7.4-fpm start

rm -rf		*

wp			core download --allow-root
cat			wp-config-sample.php > wp-config.php

wp config set DB_HOST mariadb --type=constant --allow-root
wp config set DB_NAME $DB_NAME --path=/var/www/html --allow-root
wp config set DB_USER $DB_USER --path=/var/www/html --allow-root
wp config set DB_PASSWORD $DB_PASSWORD --path=/var/www/html --allow-root

wp core install --url=$HOST_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMINPWD --admin_email=$WP_EMAIL --skip-email --allow-root

wp			user create ${WP_USER} ${WP_EMAIL1} --role=author --user_pass=${WP_USERPWD} --allow-root

service php7.4-fpm stop

php-fpm7.4 -F