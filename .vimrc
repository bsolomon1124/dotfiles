" .vimrc, Vim configuration file


set nocompatible            " required by Vundle
filetype off                " required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" """"""""""""""""""""""""""""""""""""""""""" Specify plugins here

" Plugin 'nvie/vim-flake8'                  " Python flake-8
" Plugin 'vim-syntastic/syntastic'          " syntax checking
" Plugin 'tpope/vim-fugitive'               " Git wrapper
" Plugin 'vim-scripts/indentpython.vim'     " DEPRECATED
" Plugin 'fatih/vim-go'                     " Go development
" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'tmhedberg/SimplyFold'

" Color schemes; not set until "colorscheme" specified
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'                 " low-contrast color scheme
Plugin 'gmarik/ingretu'

" """"""""""""""""""""""""""""""""""""""""""" End plugin specification

call vundle#end()            " required by Vundle
filetype plugin indent on    " required by VUndle

syntax on

" `:colo[rscheme] {name} searches 'runtimepath' for the file "colors/{name}.vim"
" example: `colo gruvbox`
" Note that these won't do much if you have a generic no-extension blank file open

:set background=dark        " does not change background color, just tells Vim what background color looks like
:set autowrite
:set hlsearch               " search highlighting
:set incsearch              " incremental search
:set ignorecase
:set smartcase              " no ignore case when a search pattern has uppercase
:set antialias
:set number
:set ruler
:set colorcolumn=72,80
:set backspace=2            " Fix Delete (backspace) on Mac OS X
:set fileformat=unix
:set nowrap
:set encoding=utf-8
:set foldmethod=indent      " folding type
:set foldlevel=99           " close folds with a level higher than this
:set clipboard=unnamed      " give access to system clipboard


" Global defaults.  These may be overriden by language-specific settings in
" ~/.vim/ftplugin/{language}.vim
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set textwidth=0
:set expandtab
:set autoindent
:set shiftround

" Emacs-style start of line / end of line navigation
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
vnoremap <silent> <C-a> ^
vnoremap <silent> <C-e> $

nnoremap <space> za                     " Enable folding with spacebar
let g:SimpylFold_docstring_preview=1    " See docstrings for folded code
