#DDL base image Debian Buster
FROM debian:buster

# update the software repository
RUN 		apt-get update && apt-get -y upgrade

# install maria-db (database)
RUN 		apt-get install -y mariadb-server

# install package to allow ps (to get PID to simulate crash)
RUN		apt-get install -y procps

# Copy config files
COPY		./tools/start_mariadb.sh /start.sh
RUN			chmod +x /start.sh
COPY		./conf/my.cnf /etc/mysql/my.cnf
RUN			chmod +rw /etc/mysql/my.cnf

# database creation (users)
COPY ./conf/mariadb.sql /root/mariadb.sql
RUN /etc/init.d/mysql start && mysql < /root/mariadb.sql

# Start server
ENTRYPOINT	["/start.sh"]

# Ports
#EXPOSE 3306
