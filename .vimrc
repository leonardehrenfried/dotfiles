" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

set rtp+="C:\Dokumente und Einstellungen\lehrenfried.MYNET\dev\home-backup\.vim"
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
set visualbell t_vb=
set mouse=a
set cmdheight=1
set number        "line numbers

set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

" == Indentation ==
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smartindent

set fileencodings=utf-8
set encoding=utf-8

let $JS_CMD='node'

" file types
au BufNewFile,BufRead *.less set filetype=less

" Excludes
:set wildignore+=*.o,*.obj,.git,.hg,CVS,target

""""""""""""""""
" CONDITIONALS "
""""""""""""""""

"Windows specific
if has('win32') 
 set guifont=Consolas
 colorscheme wombat
 set lines=999 columns=120
endif

"OS X specific
if has("gui_macvim") 
 set guifont=Monaco
 set background=dark
 colorscheme solarized
endif

"GUI specific
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
endif

" == Key Mappings ==
nmap <C-D> "_dd
imap <C-D> <Esc>"_dd

"moving lines up 
nmap <A-S-Down> mz:m+<cr>`z
nmap <A-S-Up> mz:m-2<cr>`z
imap <S-Down> <C-o>mz<C-o>:m+<cr><C-o>`z
imap <S-Up> <C-o>mz<C-o>:m-2<cr><C-o>`z
vmap <S-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <S-Up> :m'<-2<cr>`>my`<mzgv`yo`z

"tab through windows
nmap <C-Tab> <C-W>W

"replace word selected in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>"
