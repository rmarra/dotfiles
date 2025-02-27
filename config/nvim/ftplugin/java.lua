local home = os.getenv("HOME")
local jdtls = require("jdtls")
local lsp_on_attach = require("me.configs.lspconfig").on_attach
local path_to_mason = home .. "/.local/share/nvim/mason/packages"

local jdtls_path = home .. "/.local/share/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository"
local jdtls_jar_path = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar"
local path_to_config = jdtls_path .. "/config_mac_arm/"

local path_to_lombok = path_to_mason .. "/lombok-nightly/lombok.jar"

local path_to_vscode_test_glob = path_to_mason .. "/java-test/extension/server/*.jar"
local path_to_debug = '/Users/raphaelmarra/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.1.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

local function serialize_table(tbl, indent)
    indent = indent or ""
    local result = "{\n"

    for key, value in pairs(tbl) do
        local formatted_key = (type(key) == "string") and string.format("[%q]", key) or "[" .. key .. "]"
        if type(value) == "table" then
            result = result .. indent .. "  " .. formatted_key .. " = " .. serialize_table(value, indent .. "  ") .. ",\n"
        elseif type(value) == "string" then
            result = result .. indent .. "  " .. formatted_key .. " = " .. string.format("%q", value) .. ",\n"
        else
            result = result .. indent .. "  " .. formatted_key .. " = " .. tostring(value) .. ",\n"
        end
    end

    result = result .. indent .. "}"
    return result
end

-- Function to dump a Lua table to a file
local function dump_table_to_file(tbl, filename)
    local file = assert(io.open(filename, "w"))
    file:write("return " .. serialize_table(tbl) .. "\n")
    file:close()
end

local M = {}

local nnoremap = function (rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)
  require'jdtls'.setup_dap()

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  lsp_on_attach(client, bufnr)
  vim.keymap.set(
    'v',
    "<space>ca",
    "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" }
  )

  -- Java extensions provided by jdtls
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
    home .. '/.sdkman/candidates/java/21.0.6-tem/bin/java',
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
    '-jar', jdtls_jar_path,
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

 local bundles = {
   vim.fn.glob( path_to_debug, 1),
 };

 vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_vscode_test_glob, 1), "\n"))

 config['init_options'] = {
   bundles = bundles;
 }


  dump_table_to_file(config, "/Users/raphaelmarra/.local/state/marra.lua")

  require('jdtls').start_or_attach(config)
end

M.setup()
