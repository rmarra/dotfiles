return {
--  {
--    'ayu-theme/ayu-vim',
--    laze = false,
--    priority = 1000,
--    config = function ()
--      vim.o.background = dark
--      vim.cmd([[colorscheme ayu]])
--    end
--  },
  {
    'morhetz/gruvbox',
    laze = false,
    priority = 1000,
    config = function ()
      vim.cmd([[set background=dark]])
      vim.cmd([[colorscheme gruvbox]])
    end
  },
}
