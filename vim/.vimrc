set nocompatible

" Plugs {{{
" Automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au VimEnter * PlugInstall
endif
" }}}

call plug#begin('~/.vim/plugged')

" File explorer
Plug 'scrooloose/nerdtree'
" Git
Plug 'fugitive.vim'
Plug 'airblade/vim-gitgutter'
" Airline (status bar)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Ack (grep-like)
Plug 'mileszs/ack.vim'
" Executing commands in vim
Plug 'Shougo/vimproc'
Plug 'Shougo/vimshell'
" Easy commenting out
Plug 'tpope/vim-commentary'
" Color schemes
Plug 'chriskempson/base16-vim'
" Tag highlighting
Plug 'vim-scripts/TagHighlight'
" Autocompletion
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Syntax error reporting
Plug 'scrooloose/syntastic'
" Tag listing
Plug 'majutsushi/tagbar'
" Multiple cursor selection
Plug 'terryma/vim-multiple-cursors'
" Smooth scrolling
Plug 'terryma/vim-smooth-scroll'
" Documentation
Plug 'KabbAmine/zeavim.vim'
" Language-specific {{{
Plug 'octol/vim-cpp-enhanced-highlight',{'for': 'cpp'}
Plug 'groenewege/vim-less'              " LESS
Plug 'rust-lang/rust.vim'               " Rust
Plug 'neovimhaskell/haskell-vim',       {'for': 'haskell'}
Plug 'eagletmt/neco-ghc',               {'for': 'haskell'}
Plug 'jakub-olczyk/cpp.vim',             " Qt
Plug 'davidhalter/jedi-vim'             " Python
" }}}
call plug#end()

" }}}
" Leader {{{

let mapleader="\<Space>"
let maplocalleader="\<Space>"

" }}}

" UI options {{{
if has('gui_running')
  set guifont=Source\Code\Pro\ Regular\ 12

  " Remove scrollbars
  set guioptions-=L
  set guioptions-=R
  set guioptions-=T
  set guioptions-=B

  " Remove toolbar
  set guioptions=-t

  " Default size
  set lines=55 columns=230
else
  noremap <silent> <ScrollWheelUp> :call smooth_scroll#up(&scroll/3, 0, 2)<CR>
  noremap <silent> <ScrollWheelDown> :call smooth_scroll#down(&scroll/3, 0, 2)<CR>
endif
" }}}

" Plugin settings {{{

" NERDTree
nnoremap <leader>, :NERDTreeToggle<esc>
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']

" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gC :Gcommit<CR>
nnoremap <leader>gP :Git push<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'lucius'

" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_error_symbol = "!"
" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_python_exec = '/usr/bin/python2'
let g:syntastic_python_flake8_args='--ignore=E501,F401'

" Tagbar
nnoremap <silent> <leader>l :TagbarToggle<CR>

" YouCompleteMe
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <silent> <A-.> :YcmCompleter GoTo<CR>
" Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
set tags+=./.tags
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_goto_buffer_command = 'vertical-split'
" locate the rust source code
let g:ycm_rust_src_path = '/usr/local/src/rust/src'
" add some bindings
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']

" Haskell autocompletion
let g:haskellmode_completion_ghc = 0

" }}}

" General options {{{
set number
set ruler
syntax on
filetype plugin indent on
set autoindent
set smartindent
set encoding=utf-8
set backspace=indent,eol,start
set modelines=0
set laststatus=2
set showcmd
if v:version > 703
  set undofile
  set undoreload=10000
  set undodir=~/.vim/tmp/undo/     " undo files
endif
set splitright
set splitbelow
set autoread " auto reload file on change
set mouse=a
set scrolloff=8 "keep 8 lines below/above cursor
" }}}

" Colorscheme {{{
set t_Co=256
let base16colorspace=256

set background=dark
colorscheme niflheim
"syntax enable

" Some extra highlighting
:highlight Search ctermbg=None ctermfg=12

:highlight LineNr ctermbg=black ctermfg=gray guifg=gray

" }}}

" Wrapping {{{
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list
set listchars=tab:\ \ ,trail:·

function! s:setupWrapping()
  setlocal wrap
  setlocal wrapmargin=2
  setlocal textwidth=160
  if v:version > 703
    setlocal colorcolumn=+1
  endif
endfunction

" }}}

" Searching and movement {{{
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Easier to type, and I never use the default behavior. <3 sjl
noremap H ^
noremap L lg_
" }}}

" Shift+Enter for newline {{{
noremap <S-Enter> o<Esc>
" }}}


" Easy line moving {{{
function! MoveLineUp()
  call MoveLineOrVisualUp(".", "")
endfunction

function! MoveLineDown()
  call MoveLineOrVisualDown(".", "")
endfunction

function! MoveVisualUp()
  call MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction

function! MoveVisualDown()
  call MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction

function! MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction

nnoremap <silent> <A-Up> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <A-Down> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <A-Up> <C-o>:call MoveLineUp()<CR>
inoremap <silent> <A-Down> <C-o>:call MoveLineDown()<CR>
vnoremap <silent> <A-Up> :<C-u>call MoveVisualUp()<CR>
vnoremap <silent> <A-Down> :<C-u>call MoveVisualDown()<CR>
xnoremap <silent> <A-Up> :<C-u>call MoveVisualUp()<CR>
xnoremap <silent> <A-Down> :<C-u>call MoveVisualDown()<CR>
" }}}

" provide hjkl movements in Insert mode via the <Alt> modifier key {{{
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
" }}}

" Backups and undo {{{
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set backup                       " enable backups
set backupskip=/tmp/*,/private/tmp/*"
" }}}

" Filetype specific {{{
" C# {{{
augroup c_sharp
  au!
  au Filetype cs setlocal ts=4 sw=4 sts=4
augroup END
" }}}
" C {{{
augroup c_lang
  au!
  au Filetype cpp setlocal ts=4 sw=4 sts=4
  au Filetype c setlocal ts=4 sw=4 sts=4
augroup END
" }}}
" Haskell {{{
augroup haskell
  au!
  au Filetype haskell setlocal ts=4 sw=4 sts=4
  au FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END
" }}}
" HTML {{{
  au BufRead *.html setlocal ts=2 sw=2 sts=2
  au BufRead *.html set ft=html
" }}}
" Markdown {{{
augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  au BufNewFile,BufRead *.md setlocal filetype=markdown
  au Filetype markdown call s:setupWrapping()

  " Use <localleader>1/2/3 to add headings.
  au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END
" }}}
" Nginx {{{
augroup ft_nginx
  au!
  au FileType nginx setlocal ts=4 sts=4 sw=4
augroup END
" }}}
" Php {{{
augroup ft_php
  au!
  au BufRead *.inc setlocal ts=2 sw=2 sts=2
  au BufRead *.inc set ft=php
  au BufRead *.module setlocal ts=2 sw=2 sts=2
  au BufRead *.module set ft=php
augroup END
" }}}
" Python {{{
augroup ft_python
  au!

  au FileType python setlocal ts=4 sw=4 sts=4
  " au FileType python setlocal wrap wrapmargin=2 textwidth=160 colorcolumn=+1
augroup END
" }}}
" Ruby {{{
augroup ft_ruby
  au!
  au FileType ruby call s:setupWrapping()
  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
augroup END
" }}}
" Qt {{{
augroup ft_qt
  au!
  au BufRead *.qml set ft=javascript
  au BufRead *.qrc set ft=xml
  au BufRead *.qss set ft=css
augroup END
" }}}
" }}}
" Mappings {{{
nnoremap <silent> <C-l> :noh<CR><C-L>
" edit and source vimrc easily
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>

" rewrite file with sudo
cmap w!! w !sudo tee % >/dev/null
nnoremap _md :set ft=markdown<CR>
" Allow copy-pasting to X11 in visual mode
vnoremap <C-c> "+y
" }}}
" Tab completion for commands {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
" }}}
" some autocommands {{{
augroup unrelated_au
  au!

  " function to remove trailing whitespace without moving to it
  function! s:removeTrailingWhitespace()
    normal! ma
    :%s/\s\+$//e
    normal! `a
  endfunction

  " Remove trailing whitespace
  autocmd BufWritePre * :call s:removeTrailingWhitespace()

augroup END
"}}}
" Relative number toggle {{{
function! ToggleNumberRel()
  if &relativenumber
    setlocal norelativenumber
  else
    setlocal relativenumber
  endif
endfunction

" Quickly toggle between relativenumber and number
noremap <leader>rr :call ToggleNumberRel()<CR>
" }}}
" for some reason vim searches for something
:noh
