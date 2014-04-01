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
      url="https://dl.dropbox.com/s/f26mjfhi0yvqtp2/Inconsolata-Regular.ttf?dl=1"
      curl $url -o $target
      sudo atsutil databases -remove
      sudo atsutil server -shutdown
      sudo atsutil server -ping
    fi
fi

#create ssh dir if it doesn't exist
if [ ! -d ~/.ssh/ ];
then
    echo "Creating dir ~/.ssh"
    mkdir ~/.ssh/
fi

#create the symlinks for all dotfiles
declare -a dotfiles=(
  .vimrc
  .vim
  .gitconfig
  .inputrc
  .profile
  .bashrc
  .ackrc
  .gemrc
  .hgrc
  .cvsignore
  .npmrc
  .ctags
  .rspec
  .ssh/config
  .alias
  .zshrc
)

for i in "${dotfiles[@]}"
do
    echo "Symlinking $i"
    ln -sf `pwd`/$i ~/$i
done

echo "Symlinking bin"
rm -rf ~/bin
ln -sf `pwd`/bin/ ~/bin

echo "Symlinking .sbt/plugins"
mkdir -p ~/.sbt
ln -sf `pwd`/.sbt/0.13 ~/.sbt/

echo ""
echo "*** Checking out git submodules with vundle***"

if [ ! -d .vim/bundle/vundle/ ];
then
  git clone https://github.com/gmarik/vundle.git .vim/bundle/vundle
fi
vim +BundleInstall! +qall

echo ""
echo "*** Compiling command-t ***"
cd .vim/bundle/Command-T/ruby/command-t
set +e
make clean
set -e
ruby extconf.rb
make

