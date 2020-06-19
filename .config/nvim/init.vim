call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kien/ctrlp.vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-fugitive'
Plug 'hashivim/vim-terraform'
Plug 'itchyny/lightline.vim'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'godlygeek/tabular'

call plug#end()

setglobal nocompatible

syntax on
filetype on
filetype plugin indent on
set updatetime=300


let mapleader = "\<Space>"


setglobal pastetoggle=<F2>
setglobal backupdir=/tmp//
setglobal directory=/tmp//
setglobal undodir=/tmp//
setglobal undofile

set relativenumber

setglobal fileencoding=utf-8
setglobal updatetime=100
setglobal ignorecase
setglobal smartcase
setglobal visualbell

setglobal expandtab
setglobal shiftwidth=2
setglobal tabstop=2

setglobal completeopt=menu

let g:python_host_prog = '/home/rmarra/.envs/neovim2/bin/python'
let g:python3_host_prog = '/home/rmarra/.envs/neovim3/bin/python'

map <C-c> <ESC>

nnoremap <leader>j <C-w>j 
nnoremap <leader>k <C-w>k 
nnoremap <leader>h <C-w>h 
nnoremap <leader>l <C-w>l 

noremap <leader>y "+y
noremap <leader>p "+p

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,__pycache__/,*.py[cod],*.egg-info/,.git/


autocmd FileType sh setlocal expandtab shiftwidth=2 tabstop=2 foldmethod=indent foldlevel=99
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 foldmethod=indent foldlevel=99
autocmd FileType lua setlocal shiftwidth=3 tabstop=3 

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent foldlevel=99
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


setglobal laststatus=2


set background=dark
colo gruvbox

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

" NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['*.pyc', '__pycache__', '*.swp']

" COC
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" CtrlP
let g:ctrlp_show_hidden = 1

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
