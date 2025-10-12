#!/bin/bash

mkdir ~/repo
cd ~/repo || exit
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
yay -Y --gendb
cd ~/repos

ln -sf ~/repos/dotfiles/vim_bundle ~/.vim

vim +'PlugInstall --sync' +qa

