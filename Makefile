# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/12 14:03:04 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/28 16:58:45 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

_RESET		=	\e[0m
_RED		=	\e[31m
_GREEN		=	\e[32m

COMPOSE_FILE	= ./srcs/docker-compose.yml
DATA			= /home/bschwitz/data/

NX				= nginx
WP				= wordpress
MDB				= mariadb


all: up

up:
	@sudo mkdir -p ${DATA}${MDB}
	@sudo mkdir -p ${DATA}${WP}
	@printf "${_GREEN}Building images, creating and starting containers.\n${_RESET}"
	@sudo docker compose -f ${COMPOSE_FILE} up --build -d
	
down:
	@printf "${_RED}Stopping containers and removing them.\n${_RESET}"
	@sudo docker compose -f ${COMPOSE_FILE} down

start:
	@printf "${_GREEN}Starting containers\n${_RESET}"
	@sudo docker compose -f ${COMPOSE_FILE} start

stop:
	@printf "${_RED}Stopping containers\n${_RESET}"
	@sudo docker compose -f ${COMPOSE_FILE} stop

clean: down

fclean: clean
	@echo "Deleting image.."
	@sudo docker image rm ${NX} -f >/dev/null 2>&1
	@sudo docker image rm ${WP} -f >/dev/null 2>&1
	@sudo docker image rm ${MDB} -f >/dev/null 2>&1
	@printf "${_RED}Clearing volume data: ${DATA}${MDB}.\n${_RESET}"
	@sudo rm -rf ${DATA}${MDB}
	@printf "${_RED}Clearing volume data: ${DATA}${WP}.\n${_RESET}"
	@sudo rm -rf ${DATA}${WP}
	@printf "${_RED}Clearing volume data: ${DATA}${RD}.\n${_RESET}"
	@sudo rm -rf ${DATA}
	@printf "${_RED}Removing directory: ${DATA}.\n${_RESET}"
	@sudo docker volume rm srcs_${WP}_v -f >/dev/null 2>&1
	@sudo docker volume rm srcs_${MDB}_v -f >/dev/null 2>&1
	
re: fclean all
