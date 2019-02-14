syntax on
filetype plugin indent on

" Plugin settings

" ALE completion
" let g:ale_completion_enabled = 1
" Ensure we get autocomplete for rust stdlib
let g:ycm_rust_src_path = system('rustc --print sysroot')
" Don't use default settings for resize
let g:vim_resize_disable_auto_mappings = 1
" Ensure editorconfig plays well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

let g:python3_host_prog = "/usr/local/bin/python3"

let g:deoplete#enable_at_startup = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

set mouse=a

" Load plugins
call plug#begin('~/.vim/bundle')


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug '/usr/local/opt/fzf'

" (Optional) Multi-entry selection UI.
Plug 'breuckelen/vim-resize'
Plug 'davidhalter/jedi'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'jacob-ogre/vim-syncr'
Plug 'joshdick/onedark.vim'
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
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'christoomey/vim-tmux-navigator'

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
set foldmethod=syntax  " enable syntax-aware folding
set foldlevelstart=99  " but don't fold automatically
set hidden  " for LanguageClient
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
nnoremap <C-b> :NERDTree<CR>
" Find things
nnoremap <C-f> :FZF<CR>

" LanguageClient
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Source local config if available
if !empty(glob('~/.localvimrc'))
    source ~/.localvimrc
endif
