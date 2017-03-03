#!/bin/bash

echo "############################"
echo "Installing Docker Engine..."

echo "    Setup Prerequisites - update packages..."
apt-get update

echo "    Setup Prerequisites - install image-extras..."
apt-get install -y --no-install-recommends \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

echo "    Setup Docker Repository - install download tools..."
apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

echo "    Setup Docker Repository - retrieve and add apt key..."
curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -
apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D

echo "    Setup Docker Repository - add repository..."
add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

echo "    Install Docker - update packages..."
apt-get update

echo "    Install Docker - install docker-engine..."
apt-get -y install docker-engine

echo "    Configure Setup - authorize current user to use docker..."
usermod -aG docker $USER

echo "    Configure Setup - enable docker daemon..."
systemctl enable docker

echo "Installed Docker Engine."
echo "############################"
echo "Installing Docker Compose... (version: 1.11.2)"

echo "    Install Docker Compose - download compose script..."
curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"

echo "    Install Docker Compose - allowing execution..."
chmod +x /usr/local/bin/docker-compose

echo "    Install Docker Compose - add command completion..."
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

echo "Installed Docker Compose."
echo "############################"
