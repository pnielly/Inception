#DDL base image Debian Buster
FROM debian:buster

# update the software repository
RUN apt-get update && apt-get -y upgrade

# install package to allow ps (to get PID to simulate crash)
RUN		apt-get install -y procps

# install php 7.3
RUN 	apt-get install -y php-fpm \
		php-mysql \
		tar

#install wordpress
ADD 	https://wordpress.org/latest.tar.gz /tmp/latest.tar.gz
RUN 	cd /tmp \
		&& tar xzvf latest.tar.gz \
		&& rm latest.tar.gz \
		&& mkdir /var/www \
		&& mv -f wordpress /var/www/ \
		&& chmod 755 -R /var/www/wordpress \
		&& chown -R www-data:www-data /var/www/wordpress

RUN 	rm -rf /var/www/wordpress/wp-config-sample.php
COPY	./conf/wp-config.php /var/www/wordpress
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN 	sed -i "/listen =/d" /etc/php/7.3/fpm/pool.d/www.conf
RUN 	echo "listen = 9000" >> /etc/php/7.3/fpm/pool.d/www.conf
RUN 	mkdir -p /run/php/

# start wordpress + php
COPY ./tools/start.sh /
RUN chmod +x /start.sh
CMD ["bash", "/start.sh"]

# Ports
#EXPOSE 9000
