local map = vim.keymap.set


local defaults = {
  workspace = { name = 'marra', path = '~/vaults/marra' }
}


local M = {}

M.workspaces = { defaults['workspace'] }

M.create_or_open_week_note = function ()
  local year = os.date("%Y")
  local week_number = os.date("%V")
  local markdown_files = vim.fs.find(
    function(name, _)
      return name:match(".*" .. year .. "-W" .. week_number .. "%.md$")
    end,
    { path = defaults['workspace']['path'] , type = "file" }
  )

  if #markdown_files > 0 then
    vim.cmd("edit " .. markdown_files[1])
  else
    local new_week_filename = string.format("/%s-W%s.md", year, week_number)
    vim.cmd("ObsidianNew " .. defaults['workspace']['path'] .. new_week_filename)
  end

end

M.setup_mappings = function ()
  map('n', '<leader>onn', '<cmd>ObsidianNew<CR>')
  map('n', '<leader>one', '<cmd>ObsidianExtractNote<CR>')
  map('n', '<leader>off', '<cmd>ObsidianQuickSwitch<CR>')
  map('n', '<leader>ofg', '<cmd>ObsidianSearch<CR>')
  map('n', '<leader>oe', '<cmd>Ex ' .. defaults['workspace']['path'] .. '<CR>')
  map('n', '<leader>ob', '<cmd>e ' .. defaults['workspace']['path'] .. '/5-tasks/1-backlog.md<CR>')
  map('n', '<leader>ot', '<cmd>ObsidianOpen ' .. defaults['workspace']['path'] .. '/5-tasks/0-today.md<CR>')
  map('n', '<leader>oo', M.create_or_open_week_note)
end

return M
