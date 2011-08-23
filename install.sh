#! /bin/bash -e

# set up the symlinks for all dotfiles
ln -sf `pwd`/.vimrc          ~/.vimrc
ln -sf `pwd`/.vim            ~/.vim
ln -sf `pwd`/.gitconfig      ~/.gitconfig
ln -sf `pwd`/.inputrc        ~/.inputrc
ln -sf `pwd`/.profile        ~/.profile
ln -sf `pwd`/.ackrc          ~/.ackrc
ln -sf `pwd`/.gemrc          ~/.gemrc

# setting up the git submodules
git submodule init 
git submodule update
git submodule foreach 'git checkout master && git pull'

# compile command-t
cd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
