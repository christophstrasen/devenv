SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	docker build -t christophstrasen/devenv .
.PHONY: build

run: 
	docker run -p 7000:90 christophstrasen/devenv
.PHONY: run

#pull web directory from the host computer so you can change the contents and simply refresh your browser
rundev:
	docker run -v $(curdir)web/:/usr/share/nginx/html/ -p 7000:90 christophstrasen/miwyclient	
.PHONY: rundev

