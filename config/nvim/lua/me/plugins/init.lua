return {
  -- {'nvim-java/nvim-java'},
  "nvim-lua/plenary.nvim",
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
  },


  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "me.configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "me.configs.cmp"
    end,
  },


  -- formater
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { lua = { "stylua" } },
    },
  },

  -- lsp
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },
  { 'williamboman/mason-lspconfig', opts = {} },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("me.configs.lspconfig").defaults()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "me.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    config = function ()
      return require("me.configs.telescope").defaults()
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function(opts)
      require("me.configs.obsidian").setup(opts)
    end
  },

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    opts = {},
    config = function ()
      require("me.configs.go").setup_gopher()
    end
  },

  -- JDTLS
  "mfussenegger/nvim-jdtls",
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- ui plugins to make debugging simplier
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
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
    end
  },
  -- END JDTLS



  {"metalelf0/jellybeans-nvim", dependencies = {'rktjmp/lush.nvim'}, init = function (_)
    vim.cmd [[colorscheme jellybeans-nvim]]
  end},

  -- AI 
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  }

}
