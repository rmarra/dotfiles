vim.g.mapleader = ' '
vim.g.localmapleader = ' '
vim.g.python_host_prog = '/home/rmarra/.envs/neovim2/bin/python' 
vim.g.python3_host_prog = '/home/rmarra/.envs/neovim3/bin/python' 

vim.api.nvim_command('colorscheme gruvbox')

vim.o.completeopt = 'menuone,noselect'
vim.o.background = 'dark'
vim.o.guicursor = ''
vim.o.scrolloff = 8
vim.o.incsearch = true
vim.o.updatetime = 1000
vim.o.belloff = 'all'
vim.o.swapfile = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.colorcolumn = '100'
vim.wo.wrap = false

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.swapfile = false
