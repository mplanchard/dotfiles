syntax on
filetype plugin indent on

" Plugin settings

" ALE completion
" let g:ale_completion_enabled = 1
" Save ctrlp cache between sessions
let g:ctrlp_clear_cache_on_exit = 0
" Ignore stuff I don't search for
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.?(git|hg|build|dist)$'
	\ }
let g:ctrlp_max_files = 0
" Ensure we get autocomplete for rust stdlib
let g:ycm_rust_src_path = system('rustc --print sysroot')
" Don't use default settings for resize
let g:vim_resize_disable_auto_mappings = 1
" Ensure editorconfig plays well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

set mouse=a

" Load plugins
call plug#begin('~/.vim/bundle')

Plug 'breuckelen/vim-resize'
Plug 'davidhalter/jedi'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'jacob-ogre/vim-syncr'
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
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'christoomey/vim-tmux-navigator'
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
set nocopyindent
set nosmartindent

set backspace=indent,eol,start  " normal backspace
set colorcolumn=72,79,120  " highlight columns
set foldmethod=syntax
set history=1000
set hlsearch  " highlight search matches
set incsearch  " search incrementally
set ignorecase 
set noerrorbells
set nowrap
set number
set ruler
set scrolloff=1  " show extra line above/below cursor
set showmatch  " matching parens
set smartcase  " lowercase is insensitive, specified case is sensitive
set spell spelllang=en_us  " spellcheck!
set undolevels=1000

" panes
set splitright
set splitbelow
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" set pane resizing on mac to alt+j, alt+k, etc.
nnoremap ˙ :CmdResizeLeft<CR>
nnoremap ∆ :CmdResizeDown<CR>
nnoremap ˚ :CmdResizeUp<CR>
nnoremap ¬ :CmdResizeRight<CR>
let g:resize_count = 5
" Plugin enabled stuff
colorscheme onedark

" Open nerdtree if vim invoked w/no files (decided I don't want this)
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Use C-Space as a toggle to go to/from insert mode
inoremap <C-Space> <Esc>
" for some reason this is required for normal mode, rather than <C-Space>
nnoremap <NUL> i

" Maps to plugin commands
nnoremap <C-f> :YcmCompleter GoTo<CR>
nnoremap <C-b> :NERDTree<CR>

" Source local config if available
if !empty(glob('~/.localvimrc'))
    source ~/.localvimrc
endif
