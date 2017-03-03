# Docker Nginx Setup

__Prerequisites__
- Docker Engine
  - if not installed, then run install script with root privileges  
    - `sudo ./install-docker-with-compose.sh`
    - (will install latest docker engine and docker-compose 1.11.2)

## Setup

__Scripted__
- run install script with root privileges  
  - `sudo ./install.sh`

__Manual__
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
  - *for potential debugging look at* `systemctl status docker-nginx.service`
- enable service for autostart  
  - `systemctl enable docker-nginx.service`

## Usage
- start/stop the containers  
  - `systemctl (start|stop) docker-nginx.service`
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
  - useful to work around the [certs/week limits](https://letsencrypt.org/docs/rate-limits/) of Let's Encrypt

***
#### Credits
- [jwilder/nginx-proxy (separate container setup)](https://github.com/jwilder/nginx-proxy#separate-containers)
- [JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)
