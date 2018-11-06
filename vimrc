syntax on
filetype plugin indent on

" Plugin settings

" ALE completion
let g:ale_completion_enabled = 1
" Save ctrlp cache between sessions
let g:ctrlp_clear_cache_on_exit = 0
" Ensure we get autocomplete for rust stdlib
let g:ycm_rust_src_path = system('rustc --rpint sysroot')

" Load plugins
call plug#begin('~/.vim/bundle')

Plug 'davidhalter/jedi'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'joshdick/onedark.vim'
Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'plytophogy/vim-virtualenv'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'

call plug#end()

" file locations
set directory=~/.vim/swap
set backupdir=~/.vim/backup

" whitespace
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" indention
set autoindent
set copyindent
set nosmartindent

set backspace=indent,eol,start  " normal backspace
set colorcolumn=79  " highlight column 79
set history=1000
set hlsearch  " highlight search matches
set incsearch  " search incrementally
set noerrorbells
set nowrap
set number
set ruler
set scrolloff=1  " show extra line above/below cursor
set undolevels=1000

" Plugin enabled stuff
colorscheme onedark

" Open nerdtree if vim invoked w/no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" Source local config if available
if !empty(glob('~/.localvimrc'))
    source ~/.localvimrc
endif
