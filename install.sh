#! /bin/bash -e

# OS specific stuff
OS=`uname`

if [ "$OS" == "Darwin" ]
then
    echo "*** You are on OS X. Setting defaults. ***"
    sh ./osx-defaults.sh
fi

#create ssh dir if it doesn't exist
if [ -f '~/.ssh/' ];
then
    mkdir '~/.ssh/'
    echo "Creating dir ~/.ssh"
fi

#create the symlinks for all dotfiles
declare -a dotfiles=(.vimrc .vim .gitconfig .inputrc .profile .ackrc .gemrc .hgrc .cvsignore .npmrc .ssh/config)

for i in "${dotfiles[@]}"
do
    :
    echo "Symlinking $i"
    ln -sf `pwd`/$i ~/$i
done

echo "Symlinking bin"
rm -rf ~/bin
ln -sf `pwd`/bin/ ~/bin

echo ""
echo "*** Checking out git submodules ***"
# setting up the git submodules
git submodule init
git submodule update
git submodule foreach 'git checkout master && git pull'

echo ""
echo "*** Compiling command-t ***"
cd .vim/bundle/command-t/ruby/command-t
set +e
make clean
set -e
ruby extconf.rb
make

