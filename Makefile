SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t christophstrasen/devenv .
.PHONY: build

