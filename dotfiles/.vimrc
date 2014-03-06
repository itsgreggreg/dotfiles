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

" Nicer white space characters
set listchars=tab:▸\ ,eol:¬

" Auto indent on enter press
set autoindent

" Tabs are 2 spaces
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

" Always show status bar
set laststatus=2
" Custom Status bar: Filename ColumnNum@RowNum/TotalRows DocPercent
set statusline=%F%m%r%h%w\ %v@%l/%L\ %p%%

" Remap jj to <esc> in insert mode.
inoremap jj <Esc>

" Highlight search results
set hlsearch

" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Filetypes {

  " Read Gemfile as ruby
  au BufNewFile,Bufread Gemfile set ft=ruby

" } Filetypes
