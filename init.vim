set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if !exists('g:vscode')
    source ~/.vimrc
else
    call plug#begin('~/.vim/bundle')
    Plug 'tpope/vim-surround'
    call plug#end()
endif

