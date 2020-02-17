" Some of this is from http://svn.python.org/projects/python/trunk/Misc/Vim/vimrc
setlocal colorcolumn=120
hi ColorColumn ctermbg=grey
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal smarttab
setlocal autoindent
setlocal softtabstop=4
setlocal fileformat=unix

highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
