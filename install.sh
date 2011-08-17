#! /bin/bash -e

# set up the symlinks for all dotfiles
ln -s `pwd`/.vimrc          ~/.vimrc
ln -s `pwd`/.vim            ~/.vim
ln -s `pwd`/.gitconfig      ~/.gitconfig
ln -s `pwd`/.inputrc        ~/.inputrc
ln -s `pwd`/.profile        ~/.profile
ln -s `pwd`/.ackrc          ~/.ackrc
ln -s `pwd`/.gemrc          ~/.gemrc
