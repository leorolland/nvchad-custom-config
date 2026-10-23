require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls", "yamlls", "golangci_lint_ls" }

vim.lsp.config('gopls', {
  init_options = { semanticTokens = true },
  settings = {
    gopls = {
      -- Tell gopls to look for e2e tags (add others like 'integration' if needed)
      buildFlags = { "-tags=e2e" },
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
})

-- gopls does not advertise semanticTokensProvider (dynamic-only), and since gopls
-- v0.20 its legend is custom, not the LSP standard one. nvim reads the legend only
-- from server_capabilities, so fabricate the provider with gopls's real legend.
-- Sync the arrays below with gopls internal/protocol/semtok/semtok.go (v0.24) when upgrading gopls.
local gopls_semantic_legend = {
  tokenTypes = {
    "namespace", "type", "typeParameter", "parameter", "property", "variable",
    "function", "method", "macro", "keyword", "comment", "string", "number",
    "operator", "label",
  },
  tokenModifiers = {
    "definition", "readonly", "defaultLibrary", "static",
    "array", "bool", "chan", "format", "interface", "map", "number", "pointer",
    "signature", "slice", "string", "struct", "shadowing",
  },
}
local go_lsp_group = vim.api.nvim_create_augroup("gopls-attach", { clear = false })
vim.api.nvim_create_autocmd("LspAttach", {
  group = go_lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "gopls" then
      return
    end
    if not client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = gopls_semantic_legend,
        range = true,
      }
    end
  end,
})

vim.lsp.config('golangci_lint_ls', {
  cmd = { "golangci-lint-langserver" },
  root_markers = { "go.mod", ".golangci.yml", ".golangci.yaml", ".git" },

  before_init = function(params, config)
    local root_dir = params.rootPath or (params.rootUri and params.rootUri:gsub("^file://", "")) or vim.uv.cwd()

    -- Makefiles install versioned binaries (bin/golangci-lint-<version>), pick the newest
    local local_binary
    local best = { 0, 0, 0 }
    for _, path in ipairs(vim.fn.glob(root_dir .. "/bin/golangci-lint-*", false, true)) do
      if vim.uv.fs_access(path, "X") then
        local major, minor, patch = path:match("golangci%-lint%-v?(%d+)%.(%d+)%.(%d+)")
        local v = { tonumber(major), tonumber(minor), tonumber(patch) }
        if v[1] and (v[1] > best[1]
          or (v[1] == best[1] and (v[2] > best[2]
          or (v[2] == best[2] and v[3] > best[3])))) then
          best = v
          local_binary = path
        end
      end
    end

    config.init_options = config.init_options or {}

    -- golangci-lint-langserver parses stdout as JSON: v2 dropped --out-format and defaults to text, so force JSON and a 0 exit code
    local golangci_args = { "run", "--output.json.path", "stdout", "--show-stats=false", "--issues-exit-code", "0" }

    -- v1 < 1.60 predates --output.json.path
    if local_binary and best[1] == 1 and best[2] < 60 then
      golangci_args = { "run", "--out-format", "json", "--show-stats=false", "--issues-exit-code", "0" }
    end

    config.init_options.command = { local_binary or "golangci-lint", unpack(golangci_args) }
  end,
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      validate = true,
      format = {
        enable = true,
      },
      schemas = {
        -- Kubernetes (Catch-all for k8s resources)
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.0-standalone-strict/all.json"] = {
          "/*deployment.yml",
          "/*service.yml",
          "/*ingress.yml",
          "/*deployment.yaml",
          "/*service.yaml",
          "/*ingress.yaml"
        },

        -- GitLab CI/CD
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/*.gitlab-ci.yml",

        -- Helm Chart
        ["https://raw.githubusercontent.com/helm/helm/main/docs/helm.schema.json"] = "/*/Chart.yaml",
        ["https://raw.githubusercontent.com/helm/helm/main/docs/values.schema.json"] = "/*/values*.yaml",

        -- Kustomize (Unified for .yaml and .yml)
        ["https://json.schemastore.org/kustomization.json"] = {
          "/*kustomization.yaml",
          "/*kustomization.yml"
        },

        -- Vector
        [vim.fn.expand("~/.config/.vector-schema.json")] = { -- generate with 'vector generate-schema > ~/.vector-schema.json'
          "/*vector.yaml",
          "/*vector.yml",
          "/*tests.yml"
        },
      },
    },
  },
})

vim.lsp.enable(servers)
