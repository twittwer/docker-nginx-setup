#!/bin/bash

cp -r ./docker-nginx /etc/
mkdir /etc/docker-nginx/certs

cp ./docker-nginx.service /etc/systemd/system/

systemctl daemon-reload

#systemctl start docker-nginx.service

#systemctl enable docker-nginx.service
