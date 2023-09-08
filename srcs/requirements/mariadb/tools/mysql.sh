# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    mysql.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bschwitz <marvin@42lausanne.ch>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/25 15:09:24 by bschwitz          #+#    #+#              #
#    Updated: 2023/09/05 14:50:28 by bschwitz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# !/bin/bash

mysql_install_db --user=mysql --datadir=/var/lib/mysql

mkdir -p /run/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mysqld --user=mysql --datadir=/var/lib/mysql &

pid=$!

# Wait for MariaDB to become available
until mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} ping >/dev/null 2>&1; do
	sleep 1
done

# create wordpress database and user
# modify user privileges on the database
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_HOSTNAME};"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}';"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# kill and restart database
kill "$pid"
wait "$pid"
exec mysqld --user=mysql