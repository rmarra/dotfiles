local jdtls_dap = require 'jdtls.dap'
local yaml = require 'yaml'
local posix = require 'posix'
local project_spec = '.project-env.yaml'

M = {}

local load_project_spec = function()
  local project_root = vim.fs.root(0, { 'pom.xml', 'build.gradle', 'mvnw', 'gradlew' })
  if project_root == nil then
    return nil
  end
  local project_spec_path = project_root .. '/' .. project_spec
  local fd = io.open(project_spec_path, 'r')
  if fd == nil then
    return nil
  end
  local project_spec_data = fd:read '*a'
  fd:close()
  return project_spec_data
end

local build_jvm_args = function(spec)
  local args = vim.tbl_map(function(word)
    return '-' .. word
  end, spec['jvm_args'])
  return table.concat(args, ' ')
end

local set_env_vars = function(spec)
  for key, value in ipairs(spec['env']) do
    posix.setenv(key, value)
  end
end

M.ensure_debug_config = function()
  local project_spec_data = load_project_spec()
  if project_spec_data == nil then
    return jdtls_dap.setup_dap_main_class_configs({aff = "meucu"})
  end
  local spec = yaml.eval(project_spec_data)
  if spec['env'] ~= nil then
    set_env_vars(spec)
  end
  if spec['jvm_args'] ~= nil then
    local vmArgs = build_jvm_args(spec)
    jdtls_dap.setup_dap_main_class_configs { config_overrides = { vmArgs = vmArgs } }
  end
end

return M
