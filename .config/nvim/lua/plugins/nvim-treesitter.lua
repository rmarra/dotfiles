require("nvim-treesitter.configs").setup {
    ensure_install = {"all"},
    highlight = {
        enable = true
    },
   indent = {
       enable = true,
       disable = { "python" },
   }
}
