# MediathekView

## Overview
Das Programm MediathekView durchsucht die Online-Mediatheken verschiedener Sender.

Es handelt sich hierbei um eine Portierung in einen Docker Container. Basis des Containers ist das Projekt [docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui).


## Requirements
* Docker & Docker Compose V2
* SSH/Terminal access (able to install commands/functions if non-existent)


## Install Docker, download containers und configure application
1. This script will install docker and containerd:
  ```
  curl https://raw.githubusercontent.com/dwydler/MediathekView-Docker/refs/heads/master/misc/02-docker.io-installation.sh | bash
  ```
2. For IPv6 support, edit the Docker daemon configuration file, located at `/etc/docker/daemon.json`. Configure the following parameters and run `systemctl restart docker.service` to restart docker:
  ```
  {
    "experimental": true,
    "ip6tables": true
  }
  ```
3. Clone the repository to the correct folder for docker container:
  ```
  git clone https://github.com/dwydler/MediathekView-Docker.git /opt/containers/mediathekview
  git -C /opt/containers/mediathekview checkout $(git -C /opt/containers/mediathekview tag | tail -1)
  ```
4. Create the .env file:
  ```
  cp /opt/containers/mediathekview/.env.example /opt/containers/mediathekview/.env
  cp /opt/containers/mediathekview/docker-compose.yml.example /opt/containers/mediathekview/docker-compose.yml
  ```
5. Editing `/opt/containers/mediathekview/.env` and set your parameters and data. Any change requires an restart of the containers.
6. Starting application with `docker compose -f /opt/containers/mediathekview/docker-compose.yml up -d`.
7. Don't forget to test, that the application works successfully (e.g. http://FQDN:5800/).
