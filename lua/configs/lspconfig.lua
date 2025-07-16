local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"
local configs = require 'lspconfig/configs'

nvlsp.defaults() -- loads nvchad's defaults

local servers = { "html", "cssls", "clangd", "gopls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local golangci_lint_binary = "golangci-lint"

if vim.fn.executable('custom-gcl') == 1 then
  golangci_lint_binary = 'custom-gcl'
end

-- golangcilint
lspconfig.golangci_lint_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = {'go'},
  root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
  init_options = {
    command = { golangci_lint_binary, "run", "--output.json.path", "stdout", "--show-stats=false", "--issues-exit-code=1" };
  }
}
