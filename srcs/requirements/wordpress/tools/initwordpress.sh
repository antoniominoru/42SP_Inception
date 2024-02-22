#!/bin/bash

sed -i "s/MYSQL_DATABASE/${MYSQL_DATABASE}/g" /var/www/html/wp-config.php
sed -i "s/MYSQL_USER/${MYSQL_USER}/g" /var/www/html/wp-config.php
sed -i "s/MYSQL_PASSWORD/${MYSQL_PASSWORD}/g" /var/www/html/wp-config.php
sed -i "s/WP_HOST/${WP_HOST}/g" /var/www/html/wp-config.php

exec "$@"