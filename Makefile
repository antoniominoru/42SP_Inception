# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aminoru- <aminoru-@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/22 15:23:25 by aminoru-          #+#    #+#              #
#    Updated: 2024/02/22 16:53:34 by aminoru-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

USER = aminoru-

all: hosts volumes up

up:
	docker compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@docker compose -f srcs/docker-compose.yml down

hosts:
	chmod 777 /etc/hosts && cat /etc/hosts | grep $(USER).42.fr || \
	echo "127.0.0.1 $(USER).42.fr" >> /etc/hosts

volumes:
	mkdir -p /home/$(USER)/data/wordpress && chmod 777 /home/$(USER)/data/wordpress
	mkdir -p /home/$(USER)/data/mariadb && chmod 777 /home/$(USER)/data/mariadb

prepare:
	apt -y update && apt -y upgrade
	apt -y install docker-compose-plugin
	apt -y autoremove

clean: down
	docker system prune --volumes -af
	rm -rf /home/$(USER)/data
	sed -i '/127.0.0.1 $(USER).42.fr/d' /etc/hosts

.PHONY: all clean prepare up down