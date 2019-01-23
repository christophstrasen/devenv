#!/usr/bin/env bash

h=/home/christoph

create-container() {
	docker run -ti \
		--net=host \
		--privileged \
		--rm --name $name \
		--detach-keys 'ctrl-q,ctrl-q' \
		-u `id -u $USER` \
		-v `readlink -f /var/run/docker.sock`:/var/run/docker.sock \
		-v $HOME/repo:$h/repo \
		-v $HOME/.gitconfig:$h/.gitconfig \
		-v $HOME/.ssh/:$h/.ssh \
		-v $HOME/.gnupg:$h/.gnupg \
		-v $HOME/journals/:$h/journals/ \
		-v $HOME/.jrnl_config:$h/.config/jrnl \
		`-e DISPLAY=$DISPLAY` \
		-e GH_PASS \
		-e GH_USER \
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
