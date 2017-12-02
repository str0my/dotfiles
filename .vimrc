" Plugin Manager
call plug#begin("~/.vim/plugins")

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
"Plug 'edkolev/tmuxline.vim'

"Look & feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

"Movement enhancements
Plug 'terryma/vim-expand-region'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'


call plug#end()


let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 1

" KeyBinds
let mapleader="\<Space>"

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

map <C-n> :NERDTreeToggle<CR>

" Global Settings
" IMproved mode
set nocompatible 

" Dimensions
"set lines=50
"set columns=80
set wrap
set textwidth=79
"set colorcolumn=81


" Misc
set backspace=indent,eol,start
set noerrorbells
set mouse=
set clipboard=unnamed
set splitbelow
set ttimeoutlen=50
set number


" Type w!! to write file as root
cmap w!! w !sudo tee % >/dev/null

" improve the menu completion
set completeopt=menu,menuone,longest

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable persistent undo
set undodir=~/.vim/undo
set undofile

" Searching
set incsearch
set ignorecase
set smartcase 
set hlsearch
set showmatch

" Tabs
"set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

" Backups
set nobackup
set noswapfile

" Syntax and indent
filetype plugin indent on
syntax enable

" vim-expand-region settings -- incremental visual mode
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Colorscheme
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized
