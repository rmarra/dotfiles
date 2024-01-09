return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.keybinds"] = {},
          ["core.completion"] = {
            config = {
              engine  = "nvim-cmp"
            }
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              default_workspace = "notes",
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
}
