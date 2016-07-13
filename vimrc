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

let g:ruby_path="~/.rvm/bin/ruby"

let $PATH='/usr/local/bin:' . $PATH

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

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

"key to insert mode with paste using F2 key
map <F2> :set paste<CR>i
" Leave paste mode on exit
au InsertLeave * set nopaste

" Command aliases
cabbrev tp tabprev
cabbrev tn tabnext
cabbrev tf tabfirst
cabbrev tl tablast

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

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  "syntax on
"endif


filetype plugin indent on

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

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  "autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " handlebars and mustache auto filetype detection does not work, so here it is added manually
  " change the filetype to html.mustache if using mustache in an html document
  "autocmd  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs,*.moustache set filetype=mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  "autocmd  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  "autocmd  BufNewFile,BufRead *.scala set filetype=scala syntax=scala | runtime! ftplugin/scala.vim ftplugin/scala/*.vim

augroup END


" bind K to search word under cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
let g:rspec_runner = "os_x_iterm"

" Display extra whitespace
set list listchars=tab:»·,trail:·

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
"let g:airline_theme='solarized'
set t_Co=256

:set smartcase
:set ignorecase
:set noantialias


"" color theme
"let g:solarized_termcolors=256
colorscheme base16-default
 set background=dark
 set encoding=utf-8

" gui fonts
  if has('gui_running')
  set guifont=SauceCodePowerline-Light:h11
endif

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Highlight line number of where cursor currently is
"hi CursorLineNr guifg=#050505

" Numbers
set number
" below works for macvim
set numberwidth=1

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

":nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
":nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'
":nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
":xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
":xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'


" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
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

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"


" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_enable_highlighting=0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Remove trailing whitespace on save for ruby files.
au BufWritePre *.rb :%s/\s\+$//e

" cmd n, cmd p for fwd/backward in search
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Easy navigation between splits. Instead of ctrl-w + j. Just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>



" change NERDtree colors
"hi Directory guifg=#6BA9B7 ctermfg=153

" change cursor on insert mode
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"

" add beautify cmd for js html and css
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

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

" dash mappings
"map <leader>d :Dash<CR>


" swap block mode with visual
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v

" dragVisuals
runtime plugin/dragvisuals.vim
vmap  <expr>  <left>   DVB_Drag('left')
vmap  <expr>  <right>  DVB_Drag('right')
vmap  <expr>  <down>   DVB_Drag('down')
vmap  <expr>  <up>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
let g:DVB_TrimWS = 1

" bind tagbar to f8
nmap <leader>d :TagbarToggle<CR>

"set folder glyphs on
"below line does not work for new NerdTree versions
"https://github.com/ryanoasis/vim-devicons/issues/130
"let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

imap <C-E> <C-Y>,

" set syntastic javac to work smoothly with gradle

let g:syntastic_java_checkers=['javac']
let g:syntastic_java_javac_config_file_enabled = 1

" in progress, complete to open the nearest md file
function OpenPreviousFile()
  " fix below after new relelase of todo-md
  let shellcmd = "~/Documents/workspace/pytodo/todo get-previous-file " . expand("%:t")
  let output=system(shellcmd)
  execute "e ".output
endfunction

nmap <leader>b :call OpenPreviousFile()<CR>

"syntastic toggle map
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
nnoremap <leader>e :SyntasticCheck<CR>
