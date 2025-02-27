local cmp = require "cmp"
local types = require "cmp.types"

return {
  completion = { completeopt = "menu,menuone,noselect,fuzzy" },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ['<c-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping({
       i = function(fallback)
         if cmp.visible() and cmp.get_active_entry() then
           cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
         else
           fallback()
         end
       end,
       s = cmp.mapping.confirm({ select = true }),
       c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
     }),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}
