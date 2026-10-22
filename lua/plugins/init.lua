return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
      view = {
        width = {
          min = 30,
        },
      },
      git = {
        enable = true,
        ignore = false, -- THIS LINE: Tells nvim-tree to show files ignored by .gitignore
      },
      filters = {
        dotfiles = false,
        git_ignored = false, -- THIS LINE: Ensure the filter doesn't hide them
        custom = { "^.git$" }, -- ...EXCEPT exactly ".git"
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "luadoc", "printf", "json", "xml", "go", "gomod", "gosum", "make", "sql", "yaml",
        "yang", "dockerfile", "git_rebase", "git_config", "gitcommit", "gitignore",
        "hcl", "terraform", "typescript", "javascript", "starlark", "gpg", "helm", "jsonnet", "php"
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "../configs.lspconfig"
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls", "gofumpt", "yaml-language-server", "html-lsp", "css-lsp",
        "golangci-lint-langserver", "golangci-lint",
      },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim', lazy=false,
    build = 'make'
  },
  {
    "nvim-telescope/telescope.nvim", lazy=false,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
    opts = {
      defaults = {
        file_ignore_patterns = { ".git/" },
        sorting_strategy = "ascending",
        no_ignore = true,
        hidden = true,
      },
    },
  },
  { "tpope/vim-fugitive", lazy = false},
  { "FooSoft/vim-argwrap", lazy = false},
  { "nvim-neotest/nvim-nio" },
  { "nvim-lua/plenary.nvim", lazy = false },
  { "nvim-neotest/neotest-go", lazy = false },
  {
    "nvim-neotest/neotest", lazy = false,
    config = function()
      require "configs.neotest"
    end,
  },
  { "fatih/vim-go", lazy = false },
  {
    "chentoast/marks.nvim", lazy = false,
    config = function()
      require'marks'.setup { default_mappings = true, signs = true }
    end,
  },
  {
    "leoluz/nvim-dap-go", lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
      -- "rcarriga/nvim-dap-ui"
    },
    config = function()
      local dap = require("dap")
      local dap_go = require("dap-go")

      -- 1. Initialize dap-go first (this populates the default configs)
      dap_go.setup()

      -- 2. Define your remote adapter
      dap.adapters["go-remote"] = {
        type = "server",
        host = "127.0.0.1",
        port = 30000,
        -- no execute config = dlv is already ran by Tilt
      }

      -- 3. APPEND to the existing configurations instead of overwriting
      -- This keeps the "Debug test" and "Debug" options provided by dap-go
      table.insert(dap.configurations.go, {
        type = "go-remote",
        name = "dlv connect localhost:30000",
        mode = "remote",
        request = "attach",
        substitutePath = {
          -- { from = "${workspaceFolder}", to = "/" },
        },
      })

      -- 4. UI Setup
      -- require("dapui").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui", lazy = false,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function() require("dapui").setup() end,
  },
  {
    'likec4/likec4.nvim', lazy = false,
    build = 'npm install -g @likec4/language-server'
  }
}
