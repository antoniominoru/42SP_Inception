FROM debian:buster

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG WP_HOST

RUN apt update && apt install -y php7.3-fpm php7.3-mysql mariadb-client wget bash\
	&& mkdir -p /var/run/php && chmod 777 /var/run/php \
	&& mkdir -p /var/www/html && chmod 777 /var/www/html \
	&& wget https://br.wordpress.org/wordpress-6.1.1-pt_BR.tar.gz \
	&& tar xzf wordpress-6.1.1-pt_BR.tar.gz \
    && mv wordpress/* /var/www/html \
    && rm wordpress-6.1.1-pt_BR.tar.gz && rm -rf wordpress \
	&& sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf" \
	&& touch /run/php/php7.3-fpm.pid

COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./tools/initwordpress.sh initwordpress.sh
RUN chmod +x initwordpress.sh && bash initwordpress.sh && rm -f initwordpress.sh

EXPOSE 9000

CMD ["php-fpm7.3",  "-F"]