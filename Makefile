# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/30 15:01:15 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/05 15:02:59 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

_RESET		=	\e[0m
_RED		=	\e[31m
_GREEN		=	\e[32m

COMPOSE_FILE	= ./srcs/docker-compose.yml

DATA			= /Users/bastien/data/

NX				= nginx
WP				= wordpress
MDB				= mariadb

all: up

up:
	@mkdir -p ${DATA}${MDB}
	@mkdir -p ${DATA}${WP}
	@mkdir -p ${DATA}${STA}
	@mkdir -p ${DATA}${MIN}
	@printf "${_GREEN}Building images, creating and starting containers.\n${_RESET}"
	@docker compose -f ${COMPOSE_FILE} up --build -d

down:
	@printf "${_RED}Stopping containers and removing them.\n${_RESET}"
	@docker compose -f ${COMPOSE_FILE} down

start:
	@printf "${_GREEN}Starting containers\n${_RESET}"
	@docker compose -f ${COMPOSE_FILE} start

stop:
	@printf "${_RED}Stopping containers\n${_RESET}"
	@docker compose -f ${COMPOSE_FILE} stop

clean: down

fclean: clean
	@echo "Deleting image.."
	@docker image rm ${NX}_i -f >/dev/null 2>&1
	@docker image rm ${WP}_i -f >/dev/null 2>&1
	@docker image rm ${MDB}_i -f >/dev/null 2>&1
	@printf "${_RED}Clearing volume data: ${DATA}${MDB}.\n${_RESET}"
	@rm -rf ${DATA}${MDB}
	@printf "${_RED}Clearing volume data: ${DATA}${WP}.\n${_RESET}"
	@rm -rf ${DATA}${WP}
	@printf "${_RED}Deleting volumes.\n${_RESET}"
	@docker volume rm ${WP}_v -f >/dev/null 2>&1
	@docker volume rm ${MDB}_v -f >/dev/null 2>&1
	
re: fclean all