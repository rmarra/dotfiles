return {
  'nvim-lua/plenary.nvim',

  {
    'github/copilot.vim',
    enabled = false,
  },

  {
    'folke/which-key.nvim',
    keys = { '<leader>', '<c-w>', '"', "'", '`', 'c', 'v', 'g' },
    cmd = 'WhichKey',
  },

  {
    'metalelf0/jellybeans-nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    init = function(_)
      vim.cmd [[colorscheme jellybeans-nvim]]
    end,
  },
}
