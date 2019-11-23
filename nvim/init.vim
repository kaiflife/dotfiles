""" Common
syntax on
colorscheme desert
set encoding=UTF-8
set mouse=a
set termguicolors
set background=dark
set clipboard=unnamedplus
set noswapfile
set updatetime=300
set shell=zsh

" Indentation
set wrap
set textwidth=79
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set smartindent

filetype on
filetype plugin on
filetype indent on

set autoread
au FocusGained * :checktime

set number relativenumber

if exists('&colorcolumn')
  set colorcolumn=80
endif

""" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
call plug#end()
