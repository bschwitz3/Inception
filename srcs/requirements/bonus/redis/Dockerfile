# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/22 01:07:20 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/26 11:43:29 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get install -y redis-server

COPY ./conf/redis.conf /etc/redis/redis.conf
RUN chmod +x /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server"]

# test : exec redis -> redis-cli -> ping = PONG