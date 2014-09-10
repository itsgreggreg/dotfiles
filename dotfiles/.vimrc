" -- VUNDLE --
" for setup see: https://github.com/gmarik/Vundle.vim
" required for vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

" optional bundles
" To install start vim and run :PluginInstall
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-haml'
Plugin 'digitaltoad/vim-jade'
Plugin 'kchmck/vim-coffee-script'
" Comment out lines/selections with <ctl>--
Plugin 'tomtom/tcomment_vim'
Plugin 'itsgreggreg/tabline.vim'
" <ctl>p opens up a project file search, <ctrl>k/j navigate
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'rking/ag.vim'

" All Plugins must be added before the following
call vundle#end()
filetype plugin indent on


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
syntax enable

" Always show status bar
set laststatus=2
" Custom Status bar: Filename ColumnNum@RowNum/TotalRows DocPercent
set statusline=%F%m%r%h%w\ %v@%l/%L\ %p%%

" Highlight search results
set hlsearch

" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Code folding
set foldmethod=indent
set nofoldenable

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

" Doubleclick to toggle code fold
map <2-LeftMouse> za

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
au BufnewFile,Bufread *.coffee set ft=coffee


" -- CUSTOM COMMANDS --
" Tabnew shortcut
" TODO: tab completion
command! -nargs=? T tabnew <args>

" Edit Vimrc
command! Vrc tabnew ~/.vimrc
