# Container Build

# example1
// Ubuntu image base -> apache, PHP �����Ͽ� �����̳� ����.
mkdir apache-php
cd apache-php

cat > index.php
<?php phpinfo(); ?>

# DEBIAN_FRONTEND=noninteractive -> ��Ű�� ��ġ�ÿ��� ��ȣ�ۿ� �������.

cat > Dockerfile
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
	apt install apache2 php libapache2-mod-php -y
COPY index.php /var/www/html
EXPOSE 80
CMD ["apachectl", "-DFOREGROUND"]

docker build -t apache-php:latest .
docker images
docker run --name apacheServer -d -p 80:80 apache-php
curl localhost/index.php
http://localhost/index.php


# example2
mkdir -p build/web
cd build/web
cat > Dockerfile

// Base Image, apache webserver �����.
From centos:7.5.1804
RUN yum install httpd -y
RUN echo "Hello Uchan" > /var/www/html/index.html
CMD ["/usr/sbin/httpd", "-DFOREGROUND"] 

# tag v1�� ����. .(dot)�� dockerfile�� �ִ� ��ġ�� ���� ���丮���� �ǹ�.
docker build -t web:v1 . 
docker images (docker image ls)
docker run -d --name webtest web:v1
docker inspect webtest
docker ps
curl 172.17.0.2
docker stop webtest
docker rm webtest

# builded image ����.
docker stop webtest


# ������ �������� appjs:latest �����̳ʸ� �����Ͻÿ�.

- ���� ���丮 : ~ /app_build/appjs
- /data/ckad/app.js�� ������ ~/app_build/appjs�� �̵��� �� ���� ���ǿ� �°� �����̳ʸ� ����.
	- base image : node:12
	- app.js ������ �����̳� / ���丮�� ����.
	- �����̳� ����� node app.js�� ���۵Ǿ����.
- ������ �����̳ʸ� �����Ͻÿ�.
docker run -p 8080:8080 --name appjs -d appjs
curl localhost:8080

mkdir -p ~/app_build/appjs/
cd ~/app_build/appjs/
mv /data/ckad/app.js .
cat Dockerfile

FROM node:12
COPY app.js /
CMD ["node", "app.js"]
(ENTRYPOINT ["node", "app.js"])

docker build -t appjs:latet
docker run -p 8080:8080 --name appjs -d appjs
curl localhost:8080