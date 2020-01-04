let g:python_host_prog = '/home/rmarra/.envs/neovim2/bin/python'
let g:python3_host_prog = '/home/rmarra/.envs/neovim3/bin/python'


call plug#begin('~/.config/nvim/plugged')
  " Better file browser
   Plug 'scrooloose/nerdtree'
 
   " Async autocompletion
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 
   " Completion from other opened files
   Plug 'Shougo/context_filetype.vim'
 
   " Python autocompletion
   Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
 
   " Polyglot
   Plug 'sheerun/vim-polyglot'
 
   " Generate html in a simple way
   Plug 'mattn/emmet-vim'
 
   " Git
   Plug 'tpope/vim-fugitive'
 
   " Lint
   Plug 'scrooloose/syntastic'
 
   " Colorschema
   Plug 'flazz/vim-colorschemes'
 
   " Surround
   Plug 'tpope/vim-surround'
 
   " Repeat that shit
   Plug 'tpope/vim-repeat'
 
   " Markdown
   Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
 
   " Ctrl P
   Plug 'kien/ctrlp.vim'
 
   " ACK
   Plug 'mileszs/ack.vim'

  " Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

syntax on

set nu

" tabs and spaces handling
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set ls=2

set incsearch
set hlsearch 


" navigate windows with meta+arrows
map <C-l> <c-w>l
map <C-h> <c-w>h
map <C-k> <c-w>k
map <C-j> <c-w>j



" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"


" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" ============================================================================
" Plugins settings and mappings



" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" Deoplete -----------------------------

" Use deoplete.

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0


" ColorSchema ---------------------------

set t_Co=256
colorscheme molokai


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = "npx eslint"

