#!/bin/bash

mysqld_safe --skip-syslog &

while ! mysqladmin ping -hlocalhost --silent; do
	sleep 1
done

if ! mysql -e "USE $WP_DATABASE_ENV;";

then
	mysql -e "CREATE DATABASE $WP_DATABASE_ENV;"
	mysql -e "CREATE USER '$WP_ADMIN_USER_ENV'@'%' IDENTIFY BY '$WP_ADMIN_PWD_ENV';"
	mysql -e "GRANT ALL PRIVILEGES ON $WP_DATABASE.* TO '$WP_ADMIN_USER_ENV'@'%';"
	mysql -e "FLUSH PRIVILEGES;"
fi

mysqladmin shutdown

while ! mysqladmin ping -hlocalhost --silent; do
	sleep 1
done

exec mariadbd
