" .vimrc, Vim configuration file
" Last modified: 2018-09-27

" If no file type, default to "python"
autocmd BufEnter * if &filetype == "" | setlocal ft=python | endif

:set background=dark
:set backspace=indent,eol,start
:set autoindent
:set autowrite
:set hlsearch
:set incsearch
:set number
:set ruler
:set shiftwidth=4
:set smarttab
:set softtabstop=0
:set expandtab
:set tabstop=8

if &compatible
    set nocompatible
endif

:syntax on

:function Date()
:   read !date
:endfunction
