#! /bin/bash -e

#create the symlinks for all dotfiles
declare -a dotfiles=(.vimrc .vim .gitconfig .inputrc .profile .ackrc .gemrc)

for i in "${dotfiles[@]}"
do
    :
    echo "Symlinking $i"
    ln -sf `pwd`/$i ~/$i
done

echo ""

# setting up the git submodules
git submodule init 
git submodule update
git submodule foreach 'git checkout master && git pull'

echo ""
echo "compiling command-t"
cd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
