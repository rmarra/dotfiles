vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = '120'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 500
vim.opt.belloff = 'all'

vim.opt.termguicolors = true
