return {
  'knubie/vim-kitty-navigator',
  {
    'echasnovski/mini.pairs',
    version = '*' ,
    event = "VeryLazy",
    config = function ()
      require('mini.pairs').setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'ayu_dark',
        component_separators = '|',
        section_separators = '',
      }
    },
  }
}
