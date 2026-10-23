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
    config = function()
      -- new main-branch API: ensure_installed no longer exists in setup()
      require("nvim-treesitter").install {
        "vim", "lua", "luadoc", "printf", "json", "xml", "go", "gomod", "gosum", "make", "sql", "yaml",
        "yang", "dockerfile", "git_rebase", "git_config", "gitcommit", "gitignore",
        "hcl", "terraform", "typescript", "javascript", "starlark", "gpg", "helm", "jsonnet", "php"
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "../configs.lspconfig"
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = { max_concurrent_installers = 10 },
    config = function(_, opts)
      require("mason").setup(opts)
      -- mason v2 removed ensure_installed; install missing tools on load
      local ensure = {
        "gopls", "gofumpt", "yaml-language-server", "html-lsp", "css-lsp",
        "golangci-lint-langserver", "golangci-lint",
      }
      local registry = require("mason-registry")
      registry.refresh(vim.schedule_wrap(function()
        for _, name in ipairs(ensure) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok and not pkg:is_installed() then
            pkg:install()
          end
        end
      end))
    end,
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
  -- Disable NvChad's nvim-cmp stack, replaced by blink.cmp below
  { "hrsh7th/nvim-cmp", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },
  { "hrsh7th/cmp-nvim-lua", enabled = false },
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "hrsh7th/cmp-buffer", enabled = false },
  { "https://codeberg.org/FelipeLema/cmp-async-path.git", enabled = false },
  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = { fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      keymap = {
        preset = "none",
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-d>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      snippets = { preset = "luasnip" },
      signature = { enabled = true },
      cmdline = { enabled = false },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blink")
      require("blink.cmp").setup(opts)
    end,
  },
  { "nvim-neotest/nvim-nio" },
  { "nvim-lua/plenary.nvim", lazy = false },
  {
    "fredrikaverpil/neotest-golang", lazy = false, version = "*",
    build = function()
      vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
    end,
  },
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
