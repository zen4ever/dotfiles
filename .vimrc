filetype off
filetype plugin indent on

set nocompatible

set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set sta

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" save when loosing focus
au FocusLost * :wa

" clean whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>ft Vatzf

" select just pasted text
nnoremap <leader>v V`]

" edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" faster escape
inoremap jj <ESC>

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" Easy buffer navigation
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" call pathogen
call pathogen#runtime_append_all_bundles()

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" set tabswitch for sass and html files as 2
autocmd FileType sass set sw=2
autocmd BufRead *.html set sw=2

" nginx filetype
au BufRead,BufNewFile /etc/nginx/conf/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/sites-available/* set ft=nginx
au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx

" NERD Tree
map <leader>n :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']

" pastetoggle
nmap <leader>o :set paste!<BAR>:set paste?<CR>

autocmd Filetype htmldjango source ~/.vim/ftplugin/html/sparkup.vim

set cmdheight=2

" Color scheme
syntax on
set background=dark
colorscheme delek

if has('gui_running')
    set guifont=Menlo:h12
    colorscheme mustang
    set background=dark

    let g:sparkupExecuteMapping = '<d-e>'
endif
