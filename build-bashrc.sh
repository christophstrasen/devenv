#!/bin/bash
# Add bashrc addons for powerline and etc.
cat /tmp/bashrc-additions.sh >> "$HOME/.bash_profile"
sudo rm /tmp/bashrc-additions.sh
