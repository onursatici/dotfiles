" VUNDLE
" bootstraps vundle by adding it to the runtimepath (rtp)
" manages all plugins specified in .vimrc.bundles
" ----------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
call vundle#end()
filetype plugin indent on


" SANE DEFAULTS
" assumes sensible.vim plugin exists.
" ----------------------------------------------------------
set lazyredraw                      " don't redraw executing macros
set clipboard+=unnamed              " make default register *
set cursorline                      " highlight cursor's line
set noswapfile                      " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set showcmd                         " display incomplete commands
set hlsearch                        " highlight matches
set tabstop=2
set shiftwidth=2
set expandtab                       " soft tabs
set list listchars=tab:»·,trail:·   " override sensibles characters for tab and trailing space
set t_Co=256                        " 256 colors
set smartcase ignorecase            " case insensitive if all lower, sensitive if at least one capital on search
set nomodeline                      " turn off modelines for security reasons
set display+=uhex                   " display hex codes for non printable characters
set number                          " line numbers
set numberwidth=1                   " no extra space on the gutter, before the linenumber
set splitbelow splitright           " new splits open to the right and below, more intuitive
set mouse=a                         " set mouse scroll, proper selection etc. rarely used but useful
set wildmode=list:longest,list:full " tab completion for command line


" OPIONATED OVERRIDES
" more specific modifications
" ----------------------------------------------------------
augroup vimrcEx
  autocmd!
  autocmd InsertLeave * set nopaste                 " exist paste mode when leaving insert mode
  autocmd FileType * setlocal formatoptions-=cro    " disable auto-commeting on new line
  autocmd FileType markdown setlocal spell          " enable spelling for markdown
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END
" change cursor on insert mode, works with / without tmux
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" better java highlighting, these exist on default java.vim syntax file
let java_highlight_java_lang_ids=1
let java_highlight_debug=1
" Tab completion for insert mode
" will insert tab at beginning of line,
" will use completion if not at beginning
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>


" COLORSCHEME
" using any base16 dark palette
" ----------------------------------------------------------
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
" make error and search highlights look less intimidating
au ColorScheme * hi! link Error airline_y_red
au ColorScheme * hi! link Search airline_y_bold
au ColorScheme * hi! link Interface SpecialChar
au ColorScheme * hi! link Method Function


" KEY CUSTOMIZATIONS
" mappings for often used plugins and some modified defaults
" ----------------------------------------------------------
let mapleader = "\<Space>"
map <Leader>q :qall<CR>
" nerdtree
map <Leader>/ :NERDTreeToggle<CR>
map <Leader>? :NERDTreeFind<CR>
" < and > for buffer navigation, x to close
map <leader>x :bdelete<CR>
map <leader>. :bn<CR>
map <leader>, :bp<CR>
" remove search highlights, exists in sensible.vim but hardcoded to <C-L>
map <leader>n :nohl<CR>
" tag highlighting mapping, also updates tags
map <leader>T :UpdateTypesFile<CR>
nnoremap <leader>e :SyntasticCheck<CR>
"alt + [hjkl] to resize splits
map ¬ <C-W>>
map ˙ <C-W><
map ˚ <C-W>+
map ∆ <C-W>-
" swap visual block with visual
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v
" insert tab with shift-tab
inoremap <S-Tab> <C-V><Tab>
" fzf
map <leader>a :Ag <C-R><C-W><CR>
map <leader>f :Files<CR>
map <leader>h :History<CR>
map <leader>t :Tags<CR>
augroup goMappings
  autocmd!
  autocmd FileType go map <buffer> <leader>g <Plug>(go-def)
  autocmd FileType go map <buffer> <leader>i <Plug>(go-implements)
  autocmd FileType go map <buffer> <leader>u <Plug>(go-referrers)
augroup END


augroup rustMapping
  au FileType rust map <buffer> <leader>g <Plug>(rust-def)
augroup END


" PLUGIN CUSTOMIZATIONS
" modifications on plugin options
" ----------------------------------------------------------

" airline
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline#extensions#tabline#enabled = 1

" syntastic
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_go_checkers = ['go']
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_typescript_tsc_fname = ''
" disable active mode for java
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['java', 'scala'] }

"set folder glyphs on
"https://github.com/ryanoasis/vim-devicons/issues/130
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" disable mappings in elm package
let g:elm_setup_keybindings = 0

" vim-go
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_def_mapping_enabled = 0
let g:go_def_mode = 'godef'
" fzf
set rtp+=/usr/local/opt/fzf
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
