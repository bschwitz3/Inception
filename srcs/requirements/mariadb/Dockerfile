# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/24 18:47:46 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/05 19:52:22 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

SHELL ["/bin/bash", "-c"]

RUN apt-get update -yq
RUN apt-get install systemctl -yq
RUN apt-get install mariadb-server -yq
RUN apt-get install iputils-ping -yq

RUN mkdir -p /run/mysqld /var/lib/mysql
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mysql.sh .
RUN chmod +x mysql.sh

EXPOSE 3306

CMD ["bash", "/mysql.sh"]