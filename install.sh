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

  ICNS_URL=https://raw.githubusercontent.com/zhm/macvimhax/master/MacVim.icns
  curl -s -o /Applications/MacVim.app/Contents/Resources/MacVim.icns $ICNS_URL
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
  .bash_profile
  .ackrc
  .gemrc
  .hgrc
  .cvsignore
  .npmrc
  .ctags
  .ssh/config
  .alias
  .env
  .zshrc
  .psqlrc
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
ln -sf `pwd`/.sbt/1.0 ~/.sbt/

echo "Symlinking .config/nvim"
mkdir -p ~/.config
ln -sf `pwd`/.vim   ~/.config/nvim
ln -sf `pwd`/.vimrc ~/.config/nvim/init.vim

echo "Symlinking gpg-agent.conf"
mkdir -p ~/.gnupg/
ln -sf `pwd`/gpg-agent.conf   ~/.gnupg/gpg-agent.conf

echo ""
echo "*** Checking out git submodules with vundle***"

if [ ! -d .vim/bundle/Vundle.vim/ ];
then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +BundleInstall! +qall


