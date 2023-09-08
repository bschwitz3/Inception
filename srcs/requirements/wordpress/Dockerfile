# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/25 15:47:25 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/05 17:36:37 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

SHELL ["/bin/bash", "-c"]

RUN apt-get update -yq
RUN apt-get install php-fpm -yq
RUN apt-get install php-mysql -yq
RUN apt-get install mariadb-client -yq
RUN apt-get install curl -yq
RUN apt-get install vim -yq
RUN apt-get install iputils-ping -yq

COPY conf/php.conf /etc/php/7.4/fpm/pool.d
COPY tools/auto_config.sh .

RUN chmod +x auto_config.sh

CMD ["bash", "auto_config.sh"]
