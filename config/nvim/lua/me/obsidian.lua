local map = vim.keymap.set


local defaults = {
  workspace = { name = 'marra', path = '~/vaults/marra' }
}

M = {}

M.workspaces = { defaults['workspace'] }

M.setup_mappings = function ()
  map('n', '<leader>on', '<cmd>ObsidianNew<CR>')
  map('n', '<leader>osf', '<cmd>ObsidianQuickSwitch<CR>')
  map('n', '<leader>osg', '<cmd>ObsidianSearch<CR>')
  map('n', '<leader>oen', '<cmd>ObsidianExtractNote<CR>')
  map('n', '<leader>ob', '<cmd>e ' .. defaults['workspace']['path'] .. '/5-tasks/1-backlog.md<CR>')
  map('n', '<leader>ot', '<cmd>ObsidianOpen ' .. defaults['workspace']['path'] .. '/5-tasks/0-today.md<CR>')
end

return M
