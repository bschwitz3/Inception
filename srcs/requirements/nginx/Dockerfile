# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/17 09:53:16 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/05 17:36:30 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	debian:11

SHELL ["/bin/bash", "-c"]

RUN apt-get update -yq
RUN apt-get install nginx -yq
RUN apt-get install openssl -yq
RUN apt-get install iputils-ping -yq

RUN mkdir -p /etc/ssl/private/
RUN mkdir -p /etc/ssl/certs/
RUN mkdir -p /var/www/html/
RUN mkdir -p /logs/

RUN openssl req -x509 \
	-sha256 -days 365 \
	-nodes \
	-newkey rsa:2048 -keyout /etc/ssl/private/bschwitz.42lausanne.ch.key \
	-subj "/CN=saeby.42lausanne.ch/C=CH/ST=FR/L=Remaufens" -out /etc/ssl/certs/bschwitz.42lausanne.ch.crt

COPY /conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]