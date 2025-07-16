return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "nvim-tree/nvim-tree.lua", lazy = false,
    opts = {
      view = {
        width = {
          min = 30,
        }
      },
      filters = {
        dotfiles = false,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "json",
        "xml",
        "go",
        "gomod",
        "gosum",
        "make",
        "sql",
        "yaml",
        "yang",
        "dockerfile",
        "git_rebase",
        "git_config",
        "gitcommit",
        "gitignore",
        "hcl",
        "typescript",
        "javascript"
      },
    },
  },
   {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "../configs.null-ls"
      end,
    },
     config = function()
        require "../configs.lspconfig"
     end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        -- "golangci-lint-langserver",
        -- "golangci-lint",
        "gofumpt",
        "json-lsp",
        "yaml-language-server",
        -- "typescript-language-server",
        -- "llm-ls"
      },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require('telescope').load_extension('fzf')
    end,
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      },
      sorting_strategy = "ascending",
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules/" },
        layout_config = {
            height = 0.95,
            prompt_position = "top",
            vertical = {
                mirror = true,
                preview_cutoff = 0,
            },
        },
      },
    },
  },
  { "tpope/vim-fugitive", lazy = false},
  { "FooSoft/vim-argwrap", lazy = false},
  -- { "antoinemadec/FixCursorHold.nvim" },
  { "nvim-neotest/nvim-nio" },
  { "nvim-lua/plenary.nvim", lazy = false },
  { "nvim-neotest/neotest-go", lazy = false },
  {
    "nvim-neotest/neotest", lazy = false,
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        -- your neotest config here
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
  {
    "fatih/vim-go", lazy = false
  },
  {
    "chentoast/marks.nvim", lazy = false,
     config = function()
      require'marks'.setup {
        default_mappings = true,
        signs = true,
        mappings = {}
      }
     end,
  },
  {
    "nvim-pack/nvim-spectre",
    requires = {
      "nvim-lua/plenary.nvim"
    },
  },
  {
    "ThePrimeagen/refactoring.nvim", lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go", lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require('dap-go').setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui", lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dapui").setup()
    end,
  },
  -- {
  --   "olimorris/codecompanion.nvim", lazy=false,
  --   config = function()
  --     require("codecompanion").setup({
  --       adapters = {
  --         ai_endpoints_mistral = function()
  --           return require("codecompanion.adapters").extend("openai_compatible", {
  --             env = {
  --               url = "https://oai.endpoints.preprod.ai.cloud.ovh.net/",
  --               api_key = os.getenv("AI_API_KEY"),
  --               chat_url = "/v1/chat/completions",
  --             },
  --             schema = {
  --               model = {
  --                 default = "mistral@latest"
  --               }
  --             }
  --           })
  --         end,
  --         ai_endpoints_code_completion = function()
  --           return require("codecompanion.adapters").extend("openai_compatible", {
  --             env = {
  --               url = "https://oai.endpoints.preprod.ai.cloud.ovh.net/",
  --               api_key = os.getenv("AI_API_KEY"),
  --               chat_url = "/v1/chat/completions",
  --             },
  --             schema = {
  --               model = {
  --                 default = "code_completion@latest"
  --               }
  --             }
  --           })
  --         end,
  --       },
  --       strategies = {
  --         chat = {
  --           adapter = "ai_endpoints_mistral",
  --         },
  --         inline = {
  --           adapter = "ai_endpoints_code_completion",
  --         },
  --       },
  --     })
  --   end,
  -- }
}
