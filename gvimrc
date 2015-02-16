" No audible bell
set vb

" set antialiasing for fonts
set antialias
" remove scrollbar
set guioptions=r

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local config
if filereadable($HOME . "/.gvimrc.local")
  source ~/.gvimrc.local
endif
