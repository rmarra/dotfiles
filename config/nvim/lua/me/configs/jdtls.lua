local home = os.getenv("HOME")
local jdtls = require("jdtls")
local lsp_on_attach = require("me.configs.lspconfig").on_attach
local path_to_jdtls = home .. "/.local/share/nvim/mason/packages/jdtls"
local path_to_lombok = path_to_jdtls .. "/lombok.jar"
local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
local path_to_config = path_to_jdtls .. "/config_mac"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

local M = {}

local nnoremap = function (rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  lsp_on_attach(client, bufnr)
  vim.keymap.set(
    'v',
    "<space>ca",
    "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" }
  )

  -- Java extensions provided by jdtls
  nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  vim.keymap.set(
    'v', "<space>em",
    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" }
  )
  vim.keymap.set('n', "<A-o>", jdtls.organize_imports, bufopts)
  vim.keymap.set('n', "<leader>df", jdtls.test_class, bufopts)
  vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, bufopts)
  vim.keymap.set('n', "crv", jdtls.extract_variable, bufopts)
  vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts)
  vim.keymap.set('n', "crc", jdtls.extract_constant, bufopts)
end

function M.setup()
  local config = {}
  config.on_attach = on_attach

  config.cmd = {
    home .. '/.sdkman/candidates/java/21.0.5-amzn/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '-javaagent:' .. path_to_lombok,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', path_to_jar,
    '-configuration', path_to_config,
    '-data', workspace_dir
  }

  config.root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew", "pom.xml"})

  config.settings = {
    java = {
      signatureHelp = { enabled = true };
      contentProvider = { preferred = 'fernflower' };
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      };
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        };
      };
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      };
    };
  }


  require('jdtls').start_or_attach(config)
end

return M
