" vundle{
  " for setup see: https://github.com/gmarik/Vundle.vim
  " required
  set nocompatible              " be iMproved
  filetype off

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  " alternatively, pass a path where Vundle should install bundles
  "let path = '~/some/path/here'
  "call vundle#rc(path)

  " let Vundle manage Vundle
  Bundle 'gmarik/vundle'

  filetype plugin indent on

  " optional
  " To install start vim and run :BundleInstall
  Bundle 'groenewege/vim-less'
  Bundle 'tpope/vim-haml'
  Bundle 'tomtom/tcomment_vim'
  Bundle 'itsgreggreg/tabline.vim'
  Bundle 'kien/ctrlp.vim'
  Bundle 'flazz/vim-colorschemes'
  Bundle 'rking/ag.vim'

" } vundle

" Look and feel{
  colorscheme Monokai " requires flass/vim-colorschemes
" } Look and Feel

" Start in insert mode when new file
au BufNewFile * startinsert
au VimEnter * if empty(expand("%")) | startinsert | endif

" Show Line Numbers
set number

" switch single quote and back tick
nnoremap ' `
nnoremap ` '

" show commands when pressed
set showcmd
let mapleader = ","

" Show whitespace
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

" Remap jk to <esc> in insert mode.
inoremap jk <Esc>l

" Remap jw to <esc>-save in insert mode
inoremap jw <Esc>:w<enter>l

" Highlight search results
set hlsearch

" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Filetypes {
  au BufNewFile,Bufread Gemfile set ft=ruby
  au BufNewFile,Bufread *.less set ft=less
" } Filetypes

" Move lines up and down with - and _
noremap - ddkP
noremap _ ddp

" Uppercase whole words
nnoremap <leader>u viwU

" Single bracket for indentation
nnoremap > >>
nnoremap < <<

" Tabnew shortcut
" TODO: tab completion
command! -nargs=? T tabnew <args>
" Always show tabline
set showtabline=2

" Auto reload changes to .vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Remap # to begening of line
nnoremap # ^

" Quick edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Split lines
nnoremap <C-J> a<CR><Esc>k$
