FROM  debian:buster

ARG MYSQL_DATABASE
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD

RUN apt update && apt install -y mariadb-server bash

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./conf/dump.sql dump.sql
COPY ./tools/initdb.sh initdb.sh

RUN chmod +x initdb.sh && bash initdb.sh && rm -f initdb.sh
RUN service mysql start && mysql < init_maria.sql && rm -f init_maria.sql \
	&& mysql < dump.sql && rm -f dump.sql

EXPOSE 3306

CMD ["mysqld_safe"]