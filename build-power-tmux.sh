#!/usr/bin/env bash

# Print out every line being run
set -x

# If a command fails, exit immediately.
set -e

apt-install() {
	sudo apt-get install --no-install-recommends -y "$@"
}

install-tmux() {
	# libevent-2.0-5 is a run-time requirement.
	apt-install tmux
}

install-powerline() {
	# POWER TMUX
	sudo pip install powerline-status

	# Make git status extra nice :)
	sudo pip install powerline-gitstatus
}

install-tmate() {
	curl -o /tmp/tmate.tar.gz -L https://github.com/tmate-io/tmate/releases/download/2.2.1/tmate-2.2.1-static-linux-amd64.tar.gz
	tar -xzf /tmp/tmate.tar.gz -C /tmp
	sudo cp /tmp/tmate-2.2.1-static-linux-amd64/tmate /usr/local/bin/tmate
}

sudo apt-get update

# Fix file permissions from the copy
sudo chown -R christoph:christoph "$HOME/.config"
sudo chown christoph:christoph /home/christoph/.tmux.conf
sudo chown $USER:$USER ~/.tmate.conf

# Need to update package cache...
sudo apt-get update

# We're going to want utf-8 support...
apt-install language-pack-en-base

install-powerline

install-tmux

install-tmate

# Add fzf fuzzy finder
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Cleanup cache
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get autoremove -y
