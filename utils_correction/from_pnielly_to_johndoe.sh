NEW_LOGIN=johndoe
OLD_LOGIN=pnielly

sed -i "s/LOGIN=${OLD_LOGIN}/LOGIN=${NEW_LOGIN}/g" ../Makefile
sed -i "s/${OLD_LOGIN}/${NEW_LOGIN}/g" ../srcs/docker-compose.yml
sed -i "s/${OLD_LOGIN}/${NEW_LOGIN}/g" ../srcs/.env
sed -i "s/${OLD_LOGIN}.42.fr/${NEW_LOGIN}.42.fr/g" ../srcs/requirements/mariadb/conf/mariadb.sql
