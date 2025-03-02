local map = vim.keymap.set

return {
  'olexsmir/gopher.nvim',
  ft = 'go',
  build = function()
    vim.cmd.GoInstallDeps()
  end,
  opts = {},
  config = function()
    gopher.setup {}
    map('n', '<leader>gtj', function()
      gopher.tags.add 'json'
    end)
    map('n', '<leader>gty', function()
      gopher.tags.add 'yml'
    end)
    map('n', '<leader>gtx', function()
      gopher.tags.add 'xml'
    end)
    map('n', '<leader>ge', function()
      gopher.iferr()
    end)
  end,
}
