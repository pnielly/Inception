#DDL base image Debian Buster
FROM debian:buster

# update the software repository
RUN		apt-get update && apt-get -y upgrade

# install nginx
RUN		apt-get install -y nginx wget

# install package to allow ps (to get PID to simulate crash)
RUN		apt-get install -y procps

# nginx config
COPY	conf/nginx.conf /etc/nginx/sites-available/site.conf
RUN		ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
RUN		chown -R www-data:www-data /var/www

# SSL creation
RUN 	openssl req -x509 -nodes -days 1 -newkey rsa:2048 		\
		-subj "/C=FR/ST=FRANCE/L=PARIS/O=42/CN=pnielly" \
		-keyout etc/ssl/private/nginx-cert.key					\
		-out etc/ssl/certs/nginx-cert.crt

#COPY ssl/inception.key /etc/ssl/private/nginx-cert.key
#COPY ssl/inception.crt /etc/ssl/certs/nginx-cert.crt

#RUN 	sed -i "1i\127.0.0.1\tpnielly.42.fr" /etc/hosts

# start nginx
CMD [ "nginx", "-g", "daemon off;" ]

# Ports

EXPOSE 443
