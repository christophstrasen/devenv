#!/bin/bash
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=$USER -t christophstrasen/devenv .
