# Container Build

# example1
// Ubuntu image base -> apache, PHP 연동하여 컨테이너 빌드.
mkdir apache-php
cd apache-php

cat > index.php
<?php phpinfo(); ?>

# DEBIAN_FRONTEND=noninteractive -> 패키지 설치시에도 상호작용 방지기능.

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

// Base Image, apache webserver 만들기.
From centos:7.5.1804
RUN yum install httpd -y
RUN echo "Hello Uchan" > /var/www/html/index.html
CMD ["/usr/sbin/httpd", "-DFOREGROUND"] 

# tag v1을 가짐. .(dot)는 dockerfile이 있는 위치가 현재 디렉토리임을 의미.
docker build -t web:v1 . 
docker images (docker image ls)
docker run -d --name webtest web:v1
docker inspect webtest
docker ps
curl 172.17.0.2
docker stop webtest
docker rm webtest

# builded image 삭제.
docker stop webtest


# 다음의 조건으로 appjs:latest 컨테이너를 빌드하시오.

- 빌드 디렉토리 : ~ /app_build/appjs
- /data/ckad/app.js의 파일을 ~/app_build/appjs로 이동한 후 다음 조건에 맞게 컨테이너를 빌드.
	- base image : node:12
	- app.js 파일을 컨테이너 / 디렉토리로 복사.
	- 컨테이너 실행시 node app.js가 동작되어야함.
- 빌드한 컨테이너를 실행하시오.
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