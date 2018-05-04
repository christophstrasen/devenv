#!/usr/bin/env bash

set -e

set -x

sudo apt-get update

apt-install () {
	sudo apt-get install -y --no-install-recommends "$@"
}

apt-install nano #hehe
apt-install software-properties-common -y
apt-install python3-distutils
apt-install python3-setuptools

# Fix the permissions from the copy...
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.local/share" 
sudo chown -R christoph:christoph "$HOME/.config/nvim"
sudo chown -R christoph:christoph "$HOME/.local/share"

# Install neovim
#sudo add-apt-repository ppa:neovim-ppa/unstable
#sudo apt-get update
apt-install neovim -y

# Install neovim python api.
sudo pip install neovim

# Python 3 api required for denite.vim
apt-install python3-pip
apt-install python3-neovim 
pip3 install neovim --upgrade

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo chown -R christoph:christoph "$HOME/.config/nvim"
sudo chown -R christoph:christoph "$HOME/.local/share"

# Install all plugins.
nvim +PlugInstall +qall

# Shellcheck: Grade A shell script linter
git clone -b v0.4.5 https://github.com/koalaman/shellcheck.git /tmp/shellcheck
apt-install haskell-platform
cabal update
cd /tmp/shellcheck
cabal install --force-reinstalls
sudo cp ~/.cabal/bin/shellcheck /usr/local/bin/shellcheck

# Install ctags for code jump
apt-install exuberant-ctags

nvim +UpdateRemotePlugin +qall

sudo chown -R christoph:christoph "$HOME/.config/nvim"
sudo chown -R christoph:christoph "$HOME/.local/share"

# Cleanups
sudo apt-get purge software-properties-common haskell-platform -y
sudo apt-get autoremove -y
sudo apt-get clean
rm -rf /tmp/shellcheck
rm -rf ~/.cabal
sudo rm -rf /var/lib/apt/lists/*
