" Author: Leonard Ehrenfried <http://leonard.io>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'cloudhead/neovim-fuzzy'
Bundle 'Raimondi/delimitMate'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ap/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'
Bundle 'pangloss/vim-javascript'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/Rename'
Bundle 'derekwyatt/vim-scala'
Bundle 'sukima/xmledit'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'othree/html5.vim'
Bundle 'rbgrouleff/bclose.vim'
Bundle 'vim-scripts/matchit.zip'
Bundle 'craigemery/vim-autotag'
Bundle 'rodjek/vim-puppet'
Bundle 'bullfight/sexy-railscasts-theme'
Bundle 'tpope/vim-markdown'
Bundle 'Lokaltog/vim-powerline'
Bundle 'nvie/vim-flake8'
Bundle 'Shougo/neocomplete'

Bundle 'jnurmine/Zenburn'
Bundle 'vim-scripts/Atom'
Bundle 'airblade/vim-gitgutter'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'mxw/vim-jsx'
Bundle 'lambdatoast/elm.vim'
Bundle 'rust-lang/rust.vim'
Bundle 'hashivim/vim-terraform'
Bundle 'vim-scripts/nginx.vim'

set nocompatible
filetype indent plugin on
syntax on

let g:acp_enableAtStartup = 0
let g:neocomplete_enable_at_startup = 1
"enable only manual complete
let g:neocomplete_disable_auto_complete = 1

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
" search for tags in parent folder
set tags=tags;/

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

"Windows specific
if has('win32')
 set guifont=Consolas
 colorscheme wombat
 set lines=999 columns=120
endif

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

"moving lines up and down
nnoremap <C-j> mz:m+<cr>`z
nnoremap <C-k> mz:m-2<cr>`z
inoremap <C-j> <C-o>mz<C-o>:m+<cr><C-o>`z
inoremap <C-k> <C-o>mz<C-o>:m-2<cr><C-o>`z
vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Search mappings: These will make it so that going to the next one in a
"search will center on the line it's found in.
map N Nzz
map n nzz
"clear search highlighting
noremap <silent><Leader>/ :nohls<CR>

"tab through windows
nnoremap <C-Tab> <C-W>W

"close buffer
nnoremap <C-C> :Bclose<CR>

" cycle through windows
nnoremap <A-D-Left> :bnext<CR>
nnoremap <A-D-Right> :bprevious<CR>

"next Tab
nnoremap <silent> <C-Right> :tabnext<CR>
"previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

"replace word selected in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"omnicomplete
inoremap <expr><C-space> neocomplete#start_manual_complete()

"Command-t buffer
nnoremap tt :FuzzyOpen<CR>
nnoremap tf :CommandTFlush<CR>
nnoremap tb :CommandTBuffer<CR>

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
