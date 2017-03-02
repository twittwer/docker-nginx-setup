#!/bin/bash

cp -r ./docker-nginx /etc/

if [ -d "/etc/docker-nginx/certs" ]; then
    rm -rf /etc/docker-nginx/certs
fi
mkdir /etc/docker-nginx/certs

cp ./docker-nginx.service /etc/systemd/system/

#systemctl daemon-reload

#systemctl start docker-nginx.service

#systemctl enable docker-nginx.service
