# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/12 14:03:04 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/12 14:04:11 by bschwitz         ###   ########.fr        #
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
	@printf "${_GREEN}Building images, creating and starting containers.\n${_RESET}"
	@docker compose -f ${COMPOSE_FILE} up --build -d

# --build -> build image before starting container
# -d -> runs in detached mode so that we can still use the terminal after
# --quiet-pull -> pull without progress information

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