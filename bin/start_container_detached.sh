#!/usr/bin/env bash

create-container() {
	docker run -ti \
		--net=host \
		--privileged \
		--rm --name $name \
		--detach-keys 'ctrl-q,ctrl-q' \
		-u `id -u $USER` \
		-v `readlink -f /var/run/docker.sock`:/var/run/docker.sock \
		-v $HOME/repo:/home/$USER/repo \
		-v $HOME/.gitconfig:/home/$USER/.gitconfig \
		-v $HOME/.ssh/:/home/$USER/.ssh \
		-v $HOME/.gnupg:/home/$USER/.gnupg \
		`-e DISPLAY=$DISPLAY` \
		-e GH_PASS \
		-e GH_USER \
		-e TERM=xterm-256color \
		--env SHELL=/bin/bash \
		`-v /tmp/.X11-unix:/tmp/.X11-unix:ro` \
		-d \
		christophstrasen/$name:$tag tmux new
}

name=devenv
tag=latest
if [ ! -f ~/.gitconfig ]; then
	touch ~/.gitconfig
fi
create-container "$@"
