#! /bin/bash -e

if [ -d "macvim" ]; then
  cd macvim
  git pull
  cd ..
else
  git clone https://github.com/b4winckler/macvim.git --depth 1
fi

cd macvim
export CC=clang
make distclean
./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-cscope --enable-python3interp --enable-luainterp
make
open src/MacVim/build/Release/

