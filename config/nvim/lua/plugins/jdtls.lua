return {
  'mfussenegger/nvim-jdtls',
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
      vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
      vim.keymap.set("n", "<leader>dc", dapui.close, {desc = "[D]ebug [C]lose"})
      vim.keymap.set("n", "<leader>d]", dap.step_over, {desc = "[D]ebug Step Over"})
      vim.keymap.set("n", "<leader>d}", dap.step_into, {desc = "[D]ebug Step Into"})
      vim.keymap.set("n", "<leader>d{", dap.step_out, {desc = "[D]ebug Step Out"})
    end,
  },
}
