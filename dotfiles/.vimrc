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
Plugin 'itsgreggreg/varnish'
" <ctl>p opens up a project file search, <ctrl>k/j navigate
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'

" All Plugins must be added before the following
call vundle#end()
filetype plugin indent on


" -- LOOK AND FEEL --
colorscheme panacea " requires itsgreggreg/varnish
" Monokai, up, wombat, desert. vanzan_color, vilight, void

" -- GVIM --
set guifont=Menlo\ Regular:h17

" -- REMAP MOVEMENT FOR DVORAK --
noremap t j
noremap n k
noremap s l
noremap m n
" -- REMAP SCREEN MOVEMENT FOR DVORAK --
nnoremap <C-S> <C-W>l
nnoremap <C-T> <C-W>j
nnoremap <C-N> <C-W>k
nnoremap <C-H> <C-W>h
" -- SCREEN MOVEMENT OVER NORMAL MOVEMENT --
nnoremap T 5j
nnoremap N 5k
map S $
map H ^

" -- SETTINGS --
set number         " Show Line Numbers
set colorcolumn=81 " Show the 81st column
set showcmd        " Show commands when pressed
set list           " Show whitespace
set autoindent     " Auto indent on enter press
set expandtab      " Tabs are 2 spaces
set softtabstop=2
set shiftwidth=2
set showtabline=2  " Always show tabline
set nobackup       " Don't generate backup files
set nowritebackup
set noswapfile     " No swap file
syntax enable      " Syntax highlighting
set laststatus=2   " Always show status bar
set hlsearch       " Highlight search results
set incsearch      " Show search matches as you type
set smartcase      " Case insensitiv search
set mouse=a        " Enable mouse
set visualbell     " No beep
set noerrorbells   " Don't beep
set listchars=tab:▸\ ,eol:¬   " Nicer white space characters
set history=1000     " Longer history
set undolevels=1000  " More undo levels
if v:version >= 730
  set undofile       " Store undos between runs
  set undodir=~/.vim/.undo,~/tmp,/tmp
endif
" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" Custom Status bar: Filename ColumnNum@RowNum/TotalRows DocPercent
set statusline=%F%m%r%h%w\ %v@%l/%L\ %p%%
" Code folding
" set foldmethod=indent
" set nofoldenable

" -- MAPPINGS --
" r for redo
nnoremap r <C-R>
nnoremap <C-R> <Nop>
" Many less shift presses
nnoremap ; :
" Remap tn to <esc> in insert mode.
inoremap tn <Esc>l
" " Remap hs to <esc>-save in insert mode
" inoremap hs <Esc>:w<enter>l
" Move lines up and down with - and _
noremap - ddkP
noremap _ ddp
" Single bracket for indentation
nnoremap > >>
nnoremap < <<
" Remap # to begening of line
nnoremap # ^
" Split lines with Cntrl+j
nnoremap <C-j> a<CR><Esc>k$
" Save file with zz
nnoremap zz :w<CR>
" Easier shortcut for matching brackets
nnoremap <tab> %
vnoremap <tab> %

"-- LEADER MAPPINGS --
let mapleader = "'"
" Uppercase whole words
nnoremap <leader>U viwUw
" Lowercase whole words
nnoremap <leader>u viwuw
" Double quote words
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" Single quote words
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" Clear the screen
nnoremap <leader>c :nohl<CR>
" Set working dir to current file's dir
nnoremap <leader>d :lcd %:p:h<CR>
" quick open current dir
nnoremap <leader>. :e .<CR>

" Doubleclick to toggle code fold
" map <2-LeftMouse> za

" -- AUTO COMMANDS --
" Start in insert mode when new file
" au BufNewFile * startinsert
" au VimEnter * if empty(expand("%")) | startinsert | endif

" Auto reload changes to .vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Filetypes
au BufNewFile,Bufread Gemfile set ft=ruby
au BufNewFile,Bufread *.less set ft=less
au BufNewFile,Bufread *.jade set ft=jade
au BufNewFile,Bufread *.coffee set ft=coffee
au BufNewFile,Bufread *.ex set ft=elixir
au BufNewFile,BufReadPost *.md set filetype=markdown

" -- NERDtree --
let NERDTreeIgnore=[ '\.beam$', '^\.git$' ]
let NERDTreeMapOpenInTab= 'b'
let NERDTreeMapActivateNode= '<Space>'
" -- CUSTOM COMMANDS --
" Tabnew shortcut
" TODO: tab completion
command! -nargs=? T tabnew <args>

" Edit Vimrc
command! Vrc tabnew ~/.vimrc

" -- MISC --
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" shortcut to jump to next conflict marker
nmap <silent> <leader>m /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

