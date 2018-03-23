set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" " File explorer
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" " Git
Plugin 'fugitive.vim'
Plugin 'airblade/vim-gitgutter'
" " Airline (status bar)
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" " Ack (grep-like)
Plugin 'mileszs/ack.vim'
" " Executing commands in vim
Plugin 'Shougo/vimproc'
Plugin 'Shougo/vimshell'
" " Easy commenting out
Plugin 'tpope/vim-commentary'
" " Color schemes
Plugin 'chriskempson/base16-vim'
Plugin 'flazz/vim-colorschemes'
" " Tag highlighting
Plugin 'vim-scripts/TagHighlight'
" " Tag listing
Plugin 'majutsushi/tagbar'
"  " Autocompletion
"  Plugin 'Valloric/YouCompleteMe'
"  Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" " Syntax error reporting
Plugin 'vim-syntastic/syntastic'
" " Close parenthesis, brackets, etc
Plugin 'jiangmiao/auto-pairs'
" " Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" " Multiple cursor selection
Plugin 'terryma/vim-multiple-cursors'
" " Smooth scrolling
Plugin 'terryma/vim-smooth-scroll'
" " Documentation
Plugin 'KabbAmine/zeavim.vim'
" " Language-specific {{{
Plugin 'octol/vim-cpp-enhanced-highlight',{'for': 'cpp'}
Plugin 'groenewege/vim-less',             " LESS
Plugin 'rust-lang/rust.vim',              " Rust
Plugin 'rhysd/vim-crystal',               " Crystal
Plugin 'neovimhaskell/haskell-vim',       {'for': 'haskell'}
Plugin 'eagletmt/neco-ghc',               {'for': 'haskell'}
Plugin 'jakub-olczyk/cpp.vim',            " Qt
Plugin 'nvie/vim-flake8',                 " Python
" Plugin 'WolfgangMehner/lua-support',    " Lua
Plugin 'lervag/vimtex',                   " Latex
" " }}}

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Leader {{{

let mapleader="\<Space>"
let maplocalleader="\<Space>"

" }}}

" UI options {{{
if has('gui_running')
  "set guifont=Fira\ Mono\ Regular\ 13
  set guifont=Hack\ 13
  set linespace=2

  " Remove scrollbars
  set guioptions-=L
  set guioptions-=R
  set guioptions-=T
  set guioptions-=B

  " Remove toolbar
  set guioptions=-t

  " Default size
  set lines=40 columns=130
else
  noremap <silent> <ScrollWheelUp> :call smooth_scroll#up(&scroll/3, 0, 2)<CR>
  noremap <silent> <ScrollWheelDown> :call smooth_scroll#down(&scroll/3, 0, 2)<CR>
endif
" }}}

" Plugin settings {{{

" NERDTree
nnoremap <leader>, :NERDTreeTabsToggle<esc>
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o', '\.pdf', '\.taghl', '.ycm_extra_conf.py']
let NERDTreeShowHidden=1


" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gC :Gcommit<CR>
nnoremap <leader>gP :Git push<CR>

" Airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'lucius'

" Syntastic
nnoremap <F4> :SyntasticToggleMode<CR>
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_error_symbol = ">>"
let g:syntastic_python_checkers=['flake8', 'pylint']
let g:syntastic_python_python_exec = '/usr/bin/python3'
" let g:syntastic_python_flake8_args='--ignore=E501,F401'
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["c", "cpp", "rust"],
    \ "passive_filetypes": ["python"] }

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

" Tagbar
" nnoremap <silent> <leader>l :TagbarToggle<CR>

" Cscope
nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
"nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

" " YouCompleteMe
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" nnoremap <silent> <leader>g :YcmCompleter GoTo<CR>
" nnoremap <silent> <leader>f :YcmCompleter FixIt<CR>
nnoremap <silent> <leader>d :YcmCompleter GetDoc<CR>
" Go back to previous location with <leader>b
nnoremap <leader>b <C-o>
" Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
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

" VimTeX
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
  \ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:tex_flavor = "latex"
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
set listchars=tab:··,trail:· "display tabs and trailing whitespace

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
set relativenumber

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
  au FileType c setlocal cms=//\ %s
  au FileType cpp setlocal cms=//\ %s
  au FileType cpp setlocal foldmethod=syntax foldlevel=20
  au FileType c setlocal foldmethod=syntax foldlevel=20
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
  au BufRead,BufNewFile
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set textwidth=79
      \ set expandtab
      \ set autoindent
      \ set fileformat=unix
augroup END
" }}}
" Ruby {{{
augroup ft_ruby
  au!
  au FileType ruby call s:setupWrapping()
  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
  au BufRead,BufNewFile
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set textwidth=79
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
" Java {{{
augroup ft_java
  au!
  au FileType java set tabstop=4
  au FileType java set softtabstop=4
  au FileType java set shiftwidth=4
  au FileType java set textwidth=79
  au FileType java set expandtab
  au FileType java set autoindent
  au FileType java set fileformat=unix
  au FileType java set fdm=syntax
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
