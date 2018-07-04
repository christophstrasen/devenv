#!/usr/bin/env bash
docker attach $(docker ps | grep "devenv:latest" | awk '{print $1}')
