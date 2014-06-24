" -- VUNDLE --
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
Bundle 'digitaltoad/vim-jade'


" -- LOOK AND FEEL --
colorscheme Monokai " requires flass/vim-colorschemes


" -- SETTINGS --
" Show Line Numbers
set number

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

" Always show tabline
set showtabline=2

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

" Highlight search results
set hlsearch

" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" -- MAPPINGS --
" Remap jk to <esc> in insert mode.
inoremap jk <Esc>l

" Remap jw to <esc>-save in insert mode
inoremap jw <Esc>:w<enter>l

" Move lines up and down with - and _
noremap - ddkP
noremap _ ddp

" Uppercase whole words
nnoremap <leader>u viwU

" Single bracket for indentation
nnoremap > >>
nnoremap < <<

" Remap # to begening of line
nnoremap # ^

" Quick edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Split lines with Cntrl+j
nnoremap <C-j> a<CR><Esc>k$

" Double quote word with <leader>"
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" Single quote word with <leader>'
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" switch single quote and back tick
nnoremap ' `
nnoremap ` '


" -- AUTO COMMANDS --
" Start in insert mode when new file
au BufNewFile * startinsert
au VimEnter * if empty(expand("%")) | startinsert | endif

" Auto reload changes to .vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Filetypes
au BufNewFile,Bufread Gemfile set ft=ruby
au BufNewFile,Bufread *.less set ft=less
au BufNewFile,Bufread *.jade set ft=jade


" -- CUSTOM COMMANDS --
" Tabnew shortcut
" TODO: tab completion
command! -nargs=? T tabnew <args>

" Edit Vimrc
command! Vrc tabnew ~/.vimrc
