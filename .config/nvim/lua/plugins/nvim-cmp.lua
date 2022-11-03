local cmp = require'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

function abort()
    cmp.mapping.abort()
    vim.cmd('stopinsert')
end

cmp.setup {
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "path", priority_weight = 110 },
        { name = "nvim_lsp", max_item_count = 20, priority_weight = 100 },
        { name = "buffer", max_item_count = 5, priority_weight = 85 },
        { name = "luasnip", priority_weight = 80 },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = abort(),
        ['<ESC>'] = abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
