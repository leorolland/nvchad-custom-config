require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls", "yamlls", "golangci_lint_ls" }

vim.lsp.config('gopls', {
  settings = {
    gopls = {
      -- Tell gopls to look for e2e tags (add others like 'integration' if needed)
      buildFlags = { "-tags=e2e" },
    },
  },
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
