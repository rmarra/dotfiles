VAULT_DIR = "/home/rmarra/vaults/personal"
SYNC_SCRIPT = "/home/rmarra/www/marra/scripts/sync-obsidian/sync_obsidian.py"

function is_file_in_vault(file, vault)
  local folder_concat = ""
  for i in string.gmatch(file, "[^%/]+") do
    folder_concat = folder_concat .. "/" .. i
    if folder_concat == vault then
      return true
    end
  end
  return false
end


local mygroup = vim.api.nvim_create_augroup('ObsdianSync', { clear = true })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.md',
  group = mygroup,
  callback = function (args)
    if is_file_in_vault(args.match, VAULT_DIR) then
      vim.fn.jobstart("cd " .. VAULT_DIR .. " && git pull origin master", { detach = true })

      vim.api.nvim_create_autocmd({'InsertLeave'}, {
        buffer = 0,
        group = mygroup,
        callback = function (args)
          vim.api.nvim_command('write')
          vim.fn.jobstart("python " .. SYNC_SCRIPT, { detach = true })
        end
      })
    end
  end
})

