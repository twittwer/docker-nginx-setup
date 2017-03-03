#!/bin/bash

systemctl stop docker-nginx.service

systemctl disable docker-nginx.service

rm -r /etc/docker-nginx

rm /etc/systemd/system/docker-nginx.service

systemctl daemon-reload
