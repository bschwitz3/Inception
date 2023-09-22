# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    config.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/12 13:53:52 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/22 19:51:22 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!bin/bash
cd /var/www/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
wp core config	--dbhost=$DB_HOST \
				--dbname=$DB_NAME \
				--dbuser=$DB_USER \
				--dbpass=$DB_PASSWORD \
				--allow-root

wp core install --title=$WP_TITLE \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_MAIL \
				--url=$WP_URL \
				--allow-root

wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

## redis ##
	wp config set WP_REDIS_HOST $WP_REDIS_HOST --allow-root #I put --allowroot because i am on the root user on my VM
  	wp config set WP_REDIS_PORT $WP_REDIS_PORT --raw --allow-root
	wp config set WP_CACHE true --allow-root
 	wp config set WP_CACHE_KEY_SALT $WP_CACHE_KEY_SALT --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root

cd -

# run php-fpm7.3 listening for CGI request
php-fpm7.3 -F