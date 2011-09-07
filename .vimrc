" Author: Leonard Ehrenfried <http://lenni.info>

filetype off 

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
filetype indent plugin on
syntax on

set hidden
set wildmenu "cli autocomplete
" Excludes
:set wildignore+=*.o,*.obj,.git,.hg,CVS,target
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

"""""""""""""""""
" FILE SPECIFIC "
"""""""""""""""""

" less
au BufNewFile,BufRead *.less set filetype=less

" python
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let python_highlight_all=1

" ruby 
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=79

" xml/html
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
"autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" CSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" markdown
autocmd BufNewFile,BufRead *.txt,*.markdown,*.md setlocal ft=markdown colorcolumn=79
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=79

" javascript
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=79
let javascript_enable_domhtmlcss=1

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

"moving lines up 
nmap <A-S-Down> mz:m+<cr>`z
nmap <A-S-Up> mz:m-2<cr>`z
imap <S-Down> <C-o>mz<C-o>:m+<cr><C-o>`z
imap <S-Up> <C-o>mz<C-o>:m-2<cr><C-o>`z
vmap <S-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <S-Up> :m'<-2<cr>`>my`<mzgv`yo`z

"Search mappings: These will make it so that going to the next one in a
"search will center on the line it's found in.
map N Nzz
map n nzz

"tab through windows
nmap <C-Tab> <C-W>W
"next Tab
nnoremap <silent> <C-Right> :tabnext<CR>
"previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

"replace word selected in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>"
