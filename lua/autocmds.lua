require "nvchad.autocmds"

-- checktime reloads changed buffers on these events so open buffers (and their LSPs) see external edits
-- TermLeave covers terminals embedded in nvim, where FocusGained never fires
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }, {
  command = "checktime",
})

-- fold Go table tests on file open
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*_test.go" },
  callback = function()
    vim.cmd(':silent g/t.Run/normal jzfi{') -- find all t.Run, jump 1 line below, fold inside
    vim.cmd(':silent g/testCases/normal zfi{') -- find all tabletest, fold inside
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- show diagnostics under cursor when idle
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float({ focus = false })
  end,
})
