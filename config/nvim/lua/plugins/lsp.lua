local me_lspconfig = require 'me.lsp'

return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    opts = {},
  },
  {
    'williamboman/mason-lspconfig',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lua_config = me_lspconfig.build_config()

      lua_config.settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              vim.fn.expand '$VIMRUNTIME/lua',
              vim.fn.expand '$VIMRUNTIME/lua/vim/lsp',
              vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy',
              '${3rd}/luv/library',
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      }
      require('lspconfig').lua_ls.setup(lua_config)

      local go_config = me_lspconfig.build_config()
      require('lspconfig').gopls.setup(go_config)
    end,
  },
}
