" Author: Leonard Ehrenfried <http://leonard.io>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'srstevenson/vim-picker'
Plugin 'Raimondi/delimitMate'
Plugin 'ap/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'groenewege/vim-less'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'derekwyatt/vim-scala'
Plugin 'sukima/xmledit'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'craigemery/vim-autotag'
Plugin 'tpope/vim-markdown'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/Atom'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jnurmine/Zenburn'
Plugin 'pearofducks/ansible-vim'
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2-cssomni'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'wgwoods/vim-systemd-syntax'

call vundle#end()

set nocompatible
filetype indent plugin on
syntax on

let g:acp_enableAtStartup = 0

set guicursor=

set hidden
set wildmenu "cli autocomplete
" Excludes
set wildignore+=*.o,*.obj,*.pyc
set wildignore+=tmp,**/target/*,precompiled,test-result
set wildignore+=*.jar,node_modules
set wildignore+=_site
set wildignore+=.git,.hg,CVS
set wildignore+=*.*.db "Hypersonic db files
let NERDTreeIgnore = ['\.pyc$']
set showcmd

set hlsearch
set incsearch
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent

set display=lastline
set nostartofline
set ruler
set laststatus=2

set confirm
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set mouse=a
set cmdheight=1
set number        "line numbers

set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>

" == Indentation ==
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smartindent

set fileencodings=utf-8
set encoding=utf-8

let $JS_CMD='node'

set autoread

" disable swap files
set nobackup
set nowritebackup
set noswapfile

" == Invisible chars ==
"
" https://github.com/robb/.dotfiles/blob/master/vim/.vimrc.symlink
" Display invisible characters
"
" For utf-8 use the following characters
"
"   ▸ for tabs
"   . for trailing spaces
"   ¬ for line breaks
"
" otherwise, fall back to
"
"   > for tabs
"   . for trailing spaces
"   - for line breaks

if &encoding == "utf-8"
  set list
  set listchars=tab:▸\ ,trail:.,eol:¬,nbsp:□
else
  set list
  set listchars=tab:>\ ,trail:.,eol:-,nbsp:_
endif

" Color invisible characters
"
" NonText    affects eol, extends and precedes
" SpecialKey affects nbsp, tab and trail
"highlight NonText ctermfg=DarkGrey
"highlight SpecialKey ctermfg=DarkGrey

" trailing whitespace
match Todo /\s\+$/
autocmd BufWritePre * call TrimWhitespaces()

function TrimWhitespaces()
  if &filetype != "markdown"
    :%s/\s\+$//e
  endif
endfunction

"""""""""""""""""
" LANGUAGE SPECIFIC "
"""""""""""""""""

" python
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let python_highlight_all=1

" ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=79

" xml/html
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"

" CSS
"autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

" markdown
autocmd BufNewFile,BufRead *.txt,*.markdown,*.md setlocal ft=markdown colorcolumn=79
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=79

autocmd BufNewFile,BufRead *.service setlocal ft=gitconfig

" javascript
"autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=79
let javascript_enable_domhtmlcss=1

" jsx
autocmd FileType javascript.jsx setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=80

" java
autocmd FileType java setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=80

" tex
autocmd BufNewFile,BufRead *.tex set spell

" scala
let g:scala_first_party_namespaces='\(controllers\|views\|models\|util\|de.\|relayr\)'
let g:scala_sort_across_groups=1

" xml
autocmd FileType xml autocmd BufWritePre <buffer> :%s/\s\+$//e

" Fix common misspellings

iab lenght length

""""""""""""""""
" CONDITIONALS "
""""""""""""""""

colorscheme zenburn

"OS X specific
if has("gui_macvim")
  set guioptions-=r
  set guioptions-=L
  set guifont=Source\ Code\ Pro\ Bold:h12
  set background=dark
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  let g:solarized_contrast="high"
  let g:solarized_visibility="low"
endif

if has("gui_running") && has("unix")
  set guifont=Monospace\ 9
endif

"GUI specific
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
  colorscheme atom
endif

" fix weird colors for git-gutter
highlight clear SignColumn
""""""""""""""""
" KEY MAPPINGS "
""""""""""""""""
" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

nmap <C-D> "_dd
imap <C-D> <Esc>"_dd

nnoremap <C-Right> <C-w><Right>
nnoremap <C-Left> <C-w><Left>

"close buffer
nnoremap <C-C> :Bclose<CR>

"replace word selected in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

"Command-t buffer
nnoremap tt :PickerEdit<CR>

"NERDTree
nnoremap nt :NERDTreeToggle<CR><C-W>=
nnoremap nf :NERDTreeFind<CR>

"Toggle relative
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap tn :call NumberToggle()<CR>

" got to next gitgutter hunk
nmap <silent> ]h :GitGutterNextHunk<CR>
nmap <silent> [h :GitGutterPrevHunk<CR>]

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

com! FormatJSON %!python -m json.tool

let NERDTreeShowHidden=1
