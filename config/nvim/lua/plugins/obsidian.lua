local home = os.getenv 'HOME'
local workspace = home .. '/vaults/marra'

return {
  'epwalsh/obsidian.nvim',
  version = '*',
  opts = {
    workspaces = {
      {
        name = 'vault',
        path = workspace,
        strict = true,
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    daily_notes = {
      folder = 'dailies',
    },
    notes_subdir = '0-inbox',
    new_notes_location = 'notes_subdir',
    sort_by = 'modified',
    sort_reversed = true,
    search_max_lines = 1000,

    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,
    picker = {
      name = 'telescope.nvim',
      note_mappings = {
        new = '<C-x>',
        insert_link = '<C-l>',
      },
      tag_mappings = {
        tag_note = '<C-x>',
        insert_tag = '<C-l>',
      },
    },
    ui = {
      enable = true,
      update_debounce = 200,
      max_file_length = 5000,
      checkboxes = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
      },
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
      external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
      reference_text = { hl_group = 'ObsidianRefText' },
      highlight_text = { hl_group = 'ObsidianHighlightText' },
      tags = { hl_group = 'ObsidianTag' },
      block_ids = { hl_group = 'ObsidianBlockID' },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = '#f78c6c' },
        ObsidianDone = { bold = true, fg = '#89ddff' },
        ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianImportant = { bold = true, fg = '#d73128' },
        ObsidianBullet = { bold = true, fg = '#89ddff' },
        ObsidianRefText = { underline = true, fg = '#c792ea' },
        ObsidianExtLinkIcon = { fg = '#c792ea' },
        ObsidianTag = { italic = true, fg = '#89ddff' },
        ObsidianBlockID = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
      },
    },
  },
  config = function(opts)
    require('obsidian').setup(opts)
    local map = vim.keymap.set
    map('n', '<leader>on', '<cmd>ObsidianNew<CR>')
    map('n', '<leader>osf', '<cmd>ObsidianQuickSwitch<CR>')
    map('n', '<leader>osg', '<cmd>ObsidianSearch<CR>')
    map('n', '<leader>oen', '<cmd>ObsidianExtractNote<CR>')
    map('n', '<leader>ob', '<cmd>e /Users/raphaelmarra/vaults/marra/5-tasks/1-backlog.md<CR>')
    map('n', '<leader>ot', '<cmd>ObsidianOpen /Users/raphaelmarra/vaults/marra/5-tasks/0-today.md<CR>')
  end,
}
