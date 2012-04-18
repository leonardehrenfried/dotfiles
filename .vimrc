" Author: Leonard Ehrenfried <http://lenni.info>

" needs to be there so vim has a 0 exit code when using pathogen
" http://andrewho.co.uk/weblog/vim-pathogen-with-mutt-and-git
"filetype on
"filetype off

call pathogen#infect()

set nocompatible
filetype indent plugin on
syntax on

set hidden
set wildmenu "cli autocomplete
" Excludes
set wildignore+=*.o,*.obj
set wildignore+=tmp,target,precompiled,test-result
set wildignore+=lib,modules
set wildignore+=.git,.hg,CVS
set wildignore+=*.*.db "Hypersonic db files
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
set visualbell t_vb=
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

"""""""""""""""""
" FILE SPECIFIC "
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

" java 
autocmd FileType java setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=80

autocmd FileType xml autocmd BufWritePre <buffer> :%s/\s\+$//e

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
 let g:solarized_termtrans=1
 let g:solarized_termcolors=256
 let g:solarized_contrast="high"
 let g:solarized_visibility="high"
 colorscheme solarized
endif

"GUI specific
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
endif

""""""""""""""""
" KEY MAPPINGS "
""""""""""""""""

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

" cycle through buffers
nnoremap <A-D-Left> :bnext<CR>
nnoremap <A-D-Right> :bprevious<CR>

"next Tab
nnoremap <silent> <C-Right> :tabnext<CR>
"previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

"replace word selected in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"omnicomplete
inoremap <C-space> <C-x><C-o> 

"Flush command-t buffer
nnoremap <Leader>f :CommandTFlush<CR>
nnoremap <Leader>b :CommandTBuffer<CR>
