#!/bin/bash

start() {
    /bin/echo "Starting nginx container..."
    /usr/bin/docker run -d -p 80:80 -p 443:443 \
        --name nginx \
        -v /etc/nginx/conf.d  \
        -v /etc/nginx/vhost.d \
        -v /usr/share/nginx/html \
        -v /etc/docker-nginx/certs:/etc/nginx/certs:ro \
        nginx

    /bin/echo "Starting nginx-gen container..."
    /usr/bin/docker run -d \
        --name nginx-gen \
        --volumes-from nginx \
        -v /etc/docker-nginx/nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl:ro \
        -v /etc/docker-nginx/cors_support:/etc/docker-gen/templates/cors_support:ro \
        -v /var/run/docker.sock:/tmp/docker.sock:ro \
        jwilder/docker-gen \
        -notify-sighup nginx -watch -wait 5s:30s /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf

    /bin/echo "Starting nginx-letsencrypt container..."
    /usr/bin/docker run -d \
        --name nginx-letsencrypt \
        -e "NGINX_DOCKER_GEN_CONTAINER=nginx-gen" \
        --volumes-from nginx \
        -v /etc/docker-nginx/certs:/etc/nginx/certs:rw \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        jrcs/letsencrypt-nginx-proxy-companion
}

stop() {
    /bin/echo "Stopping containers..."
    /usr/bin/docker stop nginx
    /usr/bin/docker stop nginx-gen
    /usr/bin/docker stop nginx-letsencrypt
    /bin/echo "Removing containers..."
    /usr/bin/docker rm nginx
    /usr/bin/docker rm nginx-gen
    /usr/bin/docker rm nginx-letsencrypt
    /bin/echo "Docker nginx environment cleaned."
}

case $1 in
  start|stop) "$1" ;;
esac
