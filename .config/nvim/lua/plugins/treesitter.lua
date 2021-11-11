require("nvim-treesitter.configs").setup {
    ensure_installed = {"python", "bash", "css", "dockerfile", "go", "gomod", "hcl", "javascript"},
    highlight = {
        enable = true
    },
}
