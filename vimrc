let g:python2_host_prog = '/usr/bin/python'

" Check if vim-plug installed
if empty(glob('~/.vim/autoload/plug.vim'))
    echo "Installing vim-plug..."
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin Manager
call plug#begin("~/.vim/plugins")

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
"Plug 'edkolev/tmuxline.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'

"Look & feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Movement enhancements
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'plasticboy/vim-markdown'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" TaskWiki + VimWiki

"Plug 'vimwiki/vimwiki'
"Plug 'tbabej/taskwiki'

"Load colortheme and syntax coloring last
Plug 'frankier/neovim-colors-solarized-truecolor-only'
call plug#end()


" VimWiki config - main host only
let g:vimwiki_list = [{'path': '~/workspace/notes/wiki'},
										 \{'path': '~/workspace/notes/mwiki', 'syntax':'markdown','ext':'.mdw'}]

let g:vim_markdown_folding_disabled = 1


" Airline setup
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'


" Ultsnips!
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:polyglot_disabled = ['python']


" KeyBinds
let mapleader="\<Space>"

nnoremap <tab> %
vnoremap <tab> %

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $

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
" CTags setup
set tags=./tags;/

" IMproved mode
set nocompatible 

" Misc
set backspace=indent,eol,start
set noerrorbells
set mouse=a
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

" Ignore binary files while searching
set wildignore+=*.so,*.swp,*.zip,*.o,.git/*,.hg/*,.svn/*,*.db

" Tabs
"set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

" Backups
set nobackup
set noswapfile

" Syntax and indent
filetype plugin on
syntax on

" vim-expand-region settings -- incremental visual mode
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Colorscheme
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
let g:solarized_termcolors=   256
let g:solarized_termtrans =   1
let g:solarized_contrast  =   "high"
let g:solarized_visibility=   "high"
colorscheme solarized

highlight clear LineNr                  " transparent line number column
highlight clear FoldColumn              " transparent fold column
highlight clear Folded                  " transparent fold block background
highlight clear SignColumn    
"
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE


command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

" Function to debug syntax highlighting
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

noremap <leader>p :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
