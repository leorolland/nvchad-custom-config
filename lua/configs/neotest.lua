local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
    end,
  },
}, neotest_ns)

require("neotest").setup({
  adapters = {
    require("neotest-golang")({
      runner = "gotestsum",
      go_test_args = { "-v", "-count=1", "-timeout=2s" },
    }),
  },
  floating = {
    border = "rounded",
    max_height = 0.99,
    max_width = 0.99,
    options = {},
  },
  diagnostic = {
    enabled = false,
  },
  quickfix = {
    enabled = false,
  },
})
