# Docker Setup (01.03.2017)

## Docker Engine

### Prerequisites

```
sudo apt-get update

sudo apt-get install -y --no-install-recommends \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
```

### Installation via Repo

__Repository Setup__
```
sudo apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -

apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D

sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
```

__Installation__
```
sudo apt-get update

sudo apt-get -y install docker-engine
```

__Setup Configuration__
```
sudo usermod -aG docker $USER

sudo systemctl enable docker
```

Links:
- [Official Setup Guide](https://docs.docker.com/engine/installation/linux/ubuntu/)
- [DigitalOcean Setup Guide](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)
- [Official PostInstall](https://docs.docker.com/engine/installation/linux/linux-postinstall/)

## Docker Compose

```
sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"

sudo chmod +x /usr/local/bin/docker-compose
```

__Command Completion__
```
sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
```

Links:
- [Official Setup Guide](https://docs.docker.com/compose/install/)
- [DigitalOcean Setup Guide](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-16-04)
- [Command Completion](https://docs.docker.com/compose/completion/)
