set shell=/bin/bash
runtime macros/matchit.vim

" vundle init
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
call vundle#end()
filetype off
filetype plugin indent on

set ttyfast
set lazyredraw
set clipboard=unnamed

:au FocusLost * :wa "Save on focus lost

" Sessions
let g:session_autoload = 'no'

" Leader Mappings
let mapleader = "\<Space>"
map <Leader>w :update<CR>
map <Leader>q :qall<CR>

" Toggle nerdtree with F10
map <Leader>/ :NERDTreeToggle<CR>
" Current file in nerdtree
map <Leader>? :NERDTreeFind<CR>

" Reduce timeout after <ESC> is recvd. This is only a good idea on fast links.
set ttimeout
set ttimeoutlen=20
set notimeout


" highlight vertical column of cursor
set cursorline

" Leave paste mode on exit
au InsertLeave * set nopaste

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " highlight matches
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" Display extra whitespace
set list listchars=tab:»·,trail:·
set t_Co=256
:set smartcase
:set ignorecase
:set noantialias
" color theme
set background=dark
set encoding=utf-8
colorscheme base16-default
" fix error highlighting in Error group, TODO: move this to colorscheme file, get rid of au
au ColorScheme * hi Error ctermfg=9 ctermbg=10 guifg=White guibg=Red

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell
augroup END

" bind K to search word under cursor with ag
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Numbers
set number
" below works for macvim
set numberwidth=1

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" depends on ctrlp
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

"" Treat <li> and <p> tags like the block tags they are
"let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_highlighting=0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" set syntastic javac to work smoothly with gradle
let g:syntastic_java_checkers=['javac']
let g:syntastic_java_javac_config_file_enabled = 1
" map syntastic check
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['java'] }
nnoremap <leader>e :SyntasticCheck<CR>

" change cursor on insert mode
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"

" set mouse on
set mouse=a

"set easy buffer navigation
map <leader>x :bdelete<CR>
map <leader>. :bn<CR>
map <leader>, :bp<CR>

"set easy vim pane size adjustments
map ¬ <C-W>>
map ˙ <C-W><
map ˚ <C-W>+
map ∆ <C-W>-

" disable auto-commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" remove search highlights
map <leader>n :nohl<CR>


" swap block mode with visual
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v

" bind tagbar to leader d
nmap <leader>d :TagbarToggle<CR>

"set folder glyphs on
"below line does not work for new NerdTree versions
"https://github.com/ryanoasis/vim-devicons/issues/130
"let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

"sane map for emmet
imap <C-E> <C-Y>,

" disable mappings in elm package
let g:elm_setup_keybindings = 0
