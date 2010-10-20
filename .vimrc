" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

set nocompatible
filetype indent plugin on
syntax on

set hidden
set wildmenu "cli autocomplete
set showcmd

set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent

set nostartofline
set ruler
set laststatus=2

set confirm
set t_vb=
set mouse=a
set cmdheight=2
set number        "line numbers

set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

" == Indentation ==
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent

if has("gui_running")
  colorscheme ir_black
endif


" Remove menu bar
set guioptions-=m
" Remove toolbar
set guioptions-=T
set guifont=Monaco

set fileencodings=utf-8

" == Key Mappings ==
: map <C-D> "_dd
