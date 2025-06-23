-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "github_light",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = {
  load_on_startup = false,
}

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = { "*_test.go" },
  callback = function()
    vim.cmd(':silent g/t.Run/normal jzfi{') -- find all t.Run, jump 1 line below, fold inside
    vim.cmd(':silent g/testCases/normal zfi{') -- find all tabletest, fold inside
  end,
})

autocmd("VimResized", {
  pattern = '*',
  command = 'wincmd =',
})

vim.diagnostic.config({
  virtual_text = true
})
vim.o.updatetime = 1000
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

return M
