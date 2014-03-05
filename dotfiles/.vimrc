" Start in insert mode when new file
au BufNewFile * startinsert
au VimEnter * if empty(expand("%")) | startinsert | endif

" Show Line Numbers
set number

" allows vim to handle multiple buffers without writing to disk
set hidden

" switch single quote and back tick
nnoremap ' `
nnoremap ` '

" show leader key when pressed
set showcmd
let mapleader = ","

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Default show whitespace to on
set list
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Auto indent on enter press
set autoindent

" Tabs are spaces
set expandtab

set softtabstop=2
set shiftwidth=2

" don't generate backup files
set nobackup
set nowritebackup

" no swap file
set noswapfile

" Syntax highlighting
syntax on
