" .vimrc, Vim coniguration file
" Brad Solomon <bsolomon@protonmail.com>
" Last modified: 2018-07-09

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
:set textwidth=79

if &compatible
    set nocompatible
endif

:syntax on

:function Date()
:   read !date
:endfunction
