SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	./build_container.sh
.PHONY: build

start:
	./bin/start_container_detached.sh
.PHONY: start

attach:
	./bin/attach_container.sh
.PHONY: attach
