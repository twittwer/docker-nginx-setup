#!/bin/bash

# service script dir: /etc/docker-nginx/docker-nginx.sh

/bin/echo 'Nginx container environment starting...'

/usr/bin/docker run -d -p 80:80 -p 443:443 \
        --name nginx \
        -v /etc/nginx/conf.d  \
        -v /etc/nginx/vhost.d \
        -v /usr/share/nginx/html \
        -v /etc/docker-nginx/certs:/etc/nginx/certs:ro \
        nginx

/usr/bin/docker run -d \
        --name nginx-gen \
        --volumes-from nginx \
        -v /etc/docker-nginx/nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl:ro \
        -v /var/run/docker.sock:/tmp/docker.sock:ro \
        jwilder/docker-gen \
        -notify-sighup nginx -watch -wait 5s:30s /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf

/usr/bin/docker run -d \
        --name nginx-letsencrypt \
        -e "NGINX_DOCKER_GEN_CONTAINER=nginx-gen" \
        --volumes-from nginx \
        -v /etc/docker-nginx/certs:/etc/nginx/certs:rw \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        jrcs/letsencrypt-nginx-proxy-companion

/bin/echo 'Nginx container environment started'
