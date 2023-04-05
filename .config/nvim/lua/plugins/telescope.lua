return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    {"<leader>ff", function() require('telescope.builtin').find_files() end, desc="Telescope Find Files"},
    {"<leader>fp", function() require('telescope.builtin').git_files() end, desc="Telescope Find Git Projects Files"},
    {"<leader>fg", function() require('telescope.builtin').live_grep() end, desc="Telescope Find Live Grep"}
  }
}
