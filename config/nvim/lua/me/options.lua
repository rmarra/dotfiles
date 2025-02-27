-- MAPINGS 
--

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Indenting
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2


vim.opt.number = true
vim.opt.relativenumber = true
vim.o.numberwidth = 2
vim.o.ruler = false

vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.breakindent = true
