#! /bin/bash -e

# set up the symlinks for all dotfiles
ln -sf `pwd`/.vimrc          ~/.vimrc
ln -sf `pwd`/.vim            ~/.vim
ln -sf `pwd`/.gitconfig      ~/.gitconfig
ln -sf `pwd`/.inputrc        ~/.inputrc
ln -sf `pwd`/.profile        ~/.profile
ln -sf `pwd`/.ackrc          ~/.ackrc
ln -sf `pwd`/.gemrc          ~/.gemrc

git submodule init 
git submodule update


cd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
