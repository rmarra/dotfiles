return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      char = '┊',
      show_trailing_blankline_indent = false
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  }
}
