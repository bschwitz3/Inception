# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    auto_config.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/25 17:23:58 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/05 14:57:43 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# !/bin/bash

#mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp config create	--allow-root \
					--dbname=$MYSQL_HOSTNAME \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					#--dbhost=mariadb:3306 --path='/var/www/wordpress';

# wp config set "WP_REDIS_HOST" "redis" --allow-root
# wp config set "WP_REDIS_PORT" "6379" --allow-root

# wp core install \
# 	--url=$WP_URL \
# 	--title=$WP_TITLE \
# 	--admin_name=$WP_ADMIN_NAME \
# 	--admin_password=$WP_ADMIN_PASS \
# 	--admin_email=$WP_ADMIN_EMAIL \
# 	--allow-root

# wp user create $WP_USER_NAME $WP_USER_EMAIL \
# 	--role=author \
# 	--user_pass=$WP_USER_PASS \
# 	--allow-root

# wp plugin install redis-cache --activate --allow-root

# mkdir -p /run/php/
# wp redis enable --allow-root
# /usr/sbin/php-fpm7.4 -F