local gopher = require('gopher')

local _M = {}

local map = vim.keymap.set

_M.setup_gopher = function ()
  gopher.setup({})

  map("n", '<leader>gtj', function() gopher.tags.add("json") end)
  map("n", '<leader>gty', function() gopher.tags.add("yml") end)
  map("n", '<leader>gtx', function() gopher.tags.add("xml") end)
  map("n", '<leader>ge', function() gopher.iferr() end )
end

return _M
