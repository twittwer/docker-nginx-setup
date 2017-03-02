# Docker Nginx Setup

## Setup
- copy docker-nginx directory to /etc/
  - make sure it looks like this:
```
/etc/docker-nginx
  |-certs
  |  \-{empty directory}
  |-docker-nginx.sh
  \-nginx.tmpl
```
- copy docker-nginx.service to /etc/systemd/system/
- reload sytemd
  - `systemctl daemon-reload`
- test service
  - `systemctl start docker-nginx.service`
  - `docker ps -a -f name=nginx` - should list 3 running containers
- enable service for autostart
  - `systemctl enable docker-nginx.service`

## Usage
- start a reachabel container
```
docker run -d \
  --name whoami-sample \
  -e "VIRTUAL_HOST=whoami.sample.eu" \
  -e "LETSENCRYPT_HOST=whoami.sample.eu" \
  -e "LETSENCRYPT_EMAIL=admin@sample.eu" \
  jwilder/whoami
```
- for test cases you can add `-e "LETSENCRYPT_TEST=true" \` to get a self signed certificate
  - useful to work around the 5 certs/week/domain limits of Let's Encrypt

## WARNING
- service stop is currently not implemented

***
#### Credits
- https://github.com/jwilder/nginx-proxy
  - https://github.com/jwilder/docker-gen
- https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion
