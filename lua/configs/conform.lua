-- Formatting via conform.nvim, triggered manually with <leader>fm.
-- Go formatting is handled by vim-go (gofmt on save).
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
  },
}

return options
