require("neotest").setup({
  adapters = {
    require("neotest-go")({
      experimental = {
        test_table = false,
      },
      args = { "-count=1", "-timeout=2s" }
    })
  },
  floating = {
    border = "rounded",
    max_height = 0.99,
    max_width = 0.99,
    options = {}
  },
  diagnostic = {
    enabled = false
  },
  quickfix = {
    enabled = false
  }
})
