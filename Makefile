# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pnielly <pnielly@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/08 11:34:59 by pnielly           #+#    #+#              #
#    Updated: 2021/10/16 14:41:08 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LOGIN=pnielly

SRC=srcs

VOL_DIR=/home/${LOGIN}/data

CONTAINERS=${shell docker container list -aq}

IMAGES=${shell docker image list -aq}

VOLUMES=${shell docker volume list}

NETWORKS=${shell docker network list -q}

dom_add:
	sudo sed -i "/.42.fr/d" /etc/hosts
	sudo sed -i "1i\127.0.0.1\t${LOGIN}.42.fr" /etc/hosts

dom_del:
	sudo sed -i "/127.0.0.1\t${LOGIN}.42.fr/d" /etc/hosts

del_images:
	docker rmi -f ${IMAGES}

ps_stop:
	sudo /etc/init.d/nginx stop
	sudo /etc/init.d/mysql stop

volumes:
	sudo userdel www-data && sudo useradd -u 82 www-data
	sudo mkdir -p $(VOL_DIR)/database && sudo chown -R mysql:mysql $(VOL_DIR)/database
	sudo mkdir -p $(VOL_DIR)/wp && sudo chown -R www-data:www-data $(VOL_DIR)/wp

up:	ps_stop volumes dom_add
	docker-compose -f $(SRC)/docker-compose.yml up --build -d

down:
	docker-compose -f $(SRC)/docker-compose.yml down

clean:
	docker-compose -f $(SRC)/docker-compose.yml down --rmi all

fclean:	clean dom_del
	docker volume rm -f ${VOLUMES}
	sudo rm -rf $(VOL_DIR)/database
	sudo rm -rf $(VOL_DIR)/wp
	sudo rm -rf $(VOL_DIR)

debug:
	@echo ${CONTAINERS}
	@echo ${IMAGES}

inspect:
	@echo "nginx"
	docker inspect -f "{{ .HostConfig.RestartPolicy }}" my_nginx
	@echo "restart_count"
	docker inspect -f "{{ .RestartCount }}" my_nginx
	@echo
	@echo "wordpress"
	docker inspect -f "{{ .HostConfig.RestartPolicy }}" my_wp-php
	@echo "restart_count"
	docker inspect -f "{{ .RestartCount }}" my_wp-php
	@echo
	@echo "mariadb"
	docker inspect -f "{{ .HostConfig.RestartPolicy }}" my_mariadb
	@echo "restart_count"
	docker inspect -f "{{ .RestartCount }}" my_mariadb
	@echo

re:	fclean up

.PHONY:	 up down clean fclean
