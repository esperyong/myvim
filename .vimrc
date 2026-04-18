call pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible
set modelines=0
set tabstop=4
set shiftwidth=4 
set softtabstop=4 
set expandtab
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
set relativenumber 
set undofile
let Tlist_Show_One_File=1
let mapleader=","
let g:pydoc_cmd = 'python -m pydoc' 
let g:jsx_ext_required = 0
let g:used_javascript_libs = 'underscore,jquery,react,flux,jasmine,angularjs,angularui'
let NERDTreeIgnore = ['\.coverage$','.pytest_cache','\.git$','.DS_Store','\.un.*$','\.swp$','\.pyc$','^__pycache__$']
let NERDTreeShowHidden=1
nnoremap <leader>a :Ack
nnoremap <leader>o :NERDTree <CR>
nnoremap <leader>i :TagbarToggle <CR>
nnoremap <leader>t :CtrlP <CR>
nnoremap <leader>l <F12> 
autocmd BufRead *.js setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufRead *.rb setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufRead *.html setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufRead *.jsx setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufRead *.py nmap <leader>r :!python %<CR>
autocmd BufRead *.pl nmap <leader>r :!perl -w %<CR>
autocmd BufRead *.rb nmap <leader>r :!ruby %<CR>
autocmd BufRead *.js nmap <leader>r :!node %<CR>
nmap <F8> :TagbarToggle<CR>
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set wrap
set textwidth=120
set formatoptions=qrn1
set colorcolumn=120
set guifont=PragmataPro:h18
nnoremap <up> <nop> 
nnoremap <down> <nop> 
nnoremap <left> <nop> 
nnoremap <right> <nop> 
inoremap <up> <nop> 
inoremap <down> <nop> 
inoremap <left> <nop> 
inoremap <right> <nop> 
nnoremap j gj 
nnoremap k gk
autocmd BufRead *.* colorscheme codeschool
au FocusLost * :wa
inoremap jj <ESC>

