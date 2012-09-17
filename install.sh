#! /bin/bash -e

# OS specific stuff
OS=`uname`

if [ "$OS" == "Darwin" ]
then
    echo "Detected OS X"
    echo " -> Setting defaults"
    sh ./osx-defaults.sh

    target="/Users/$USER/Library/Fonts/Inconsolata.ttf"
    if [ ! -f $target ]
    then
      echo " -> Installing Inconsolata"
      url="http://googlefontdirectory.googlecode.com/hg/inconsolata/Inconsolata.ttf"
      curl $url -o $target
      sudo atsutil databases -remove
      sudo atsutil server -shutdown
      sudo atsutil server -ping
    fi
fi

#create ssh dir if it doesn't exist
if [ -f '~/.ssh/' ];
then
    mkdir '~/.ssh/'
    echo "Creating dir ~/.ssh"
fi

#create the symlinks for all dotfiles
declare -a dotfiles=(.vimrc .vim .gitconfig .inputrc .profile .ackrc .gemrc .hgrc .cvsignore .npmrc .ctags .ssh/config)

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

