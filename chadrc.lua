---@type ChadrcConfig
local M = {}

M.ui = {
  transparency = false,
  theme = 'github_light',
  nvdash = {
    load_on_startup = true,
    -- header = {
    --   "                           ",
    --   "  ██████  ██    ██ ██   ██ ",
    --   " ██    ██ ██    ██ ██   ██ ",
    --   " ██    ██ ██    ██ ███████ ",
    --   " ██    ██  ██  ██  ██   ██ ",
    --   "  ██████    ████   ██   ██ ",
    --   "                           "
    -- },
    header = {
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⢤⣤⠔⠒⢿⣟⡛⠛⠻⣶⡶⠤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⠀⠀⠀⠀⢀⣤⣴⠶⢿⣝⡿⢤⣌⡉⠙⠒⠲⢬⣍⡙⠒⠦⣍⡓⢬⣝⡻⢽⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⠀⠀⢠⡾⣯⣈⠉⠙⢦⣈⠙⢶⣄⠉⠙⠲⠦⣤⡀⠉⠳⢦⣈⠙⢦⡈⠉⠻⣷⣽⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⠀⠀⣿⣶⡦⣌⠱⢦⣀⠈⠳⢦⣈⠙⠲⠤⣀⣀⠉⣳⣶⡤⣌⣙⣲⣭⣟⣦⣙⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⠀⣰⠏⠛⠿⣮⣿⣶⠮⠿⠾⣿⠟⠛⠿⠉⠛⠛⠛⠋⠉⠉⠉⠁⠈⠉⠀⠈⠉⠉⠙⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⣠⠇⠀⣀⣀⡀⠉⠻⣷⡀⠀⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⢰⠏⠉⠉⠁⠈⠉⠉⠉⠉⢧⢀⢸⡆⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⣿⣾⣧⣴⣾⠿⢷⣶⣄⡀⢸⠀⠀⢹⠀⣠⣶⣏⡉⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⢨⠟⢩⠉⣿⣿⣿⣺⡯⢽⣿⠀⠀⢸⡿⣿⣇⣉⣙⣶⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡿⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⢠⡞⢀⡏⠀⠙⠛⠉⠉⠀⠀⠀⠀⢀⢸⡿⢎⡙⡇⠈⢹⢿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⡾⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⣯⠿⢧⣙⡇⠀⢟⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠃⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⢼⣇⣀⣀⣀⡘⢳⡆⣀⣀⡀⠀⣰⠛⢧⠘⣳⠆⠷⣿⡴⢿⣀⣀⣀⣀⣀⣀⣀⣠⠤⣤⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⢉⣿⣭⢹⣟⢯⣅⣿⢿⣿⣿⠿⣆⣼⠳⣽⣦⠛⢙⢷⠈⠉⠉⠉⠉⠉⠉⠁⠀⢀⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠈⠿⢿⣷⣿⣿⣶⣿⣿⣿⣿⣶⣿⣾⣦⢰⣌⡳⡎⢹⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀yes ⠀⠀   ",
"⠀⠀⠀⢨⣿⣿⡿⡟⣿⢻⣿⡀⣿⣿⣉⡉⢿⣳⣍⡛⢾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⢠⣿⢿⠋⡄⣹⣼⣦⣹⡿⣟⢙⢯⠑⠀⠳⣏⣙⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⢀⣾⣿⣈⣴⣷⡏⣿⢹⣷⠀⢹⡍⠹⢇⠀⢷⣭⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣳⡀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⣿⣶⣿⣿⢋⡇⠸⡄⢿⣆⠙⣛⣿⣀⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣆⣀⣀⠀⠀⠀⠀⠀   ",
"⠀⠀⣿⣄⢸⠙⠚⡿⣄⡳⢘⣏⣷⠾⢿⡅⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀⠀⠀   ",
"⠀⠀⠈⠻⣿⣷⣄⢹⣯⡽⠛⠋⣹⡀⠟⠀⠀⠀⣀⣤⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠶  ",
"⠀⠀⠀⠀⠀⠀⠉⠁⠁⠀⢀⣾⣿⣷⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠟⠛⠉⠉⠀⠀   ",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   "
    },
    buttons = {
      { "📖 Projects", "Spc f p", "Telescope project" },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  }
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

local autocmd = vim.api.nvim_create_autocmd
-- autocmd("BufWritePost", {
--   pattern = { "*_test.go" },
--   callback = function()
--     require("neotest").run.run()
--   end,
-- })

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
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

return M
