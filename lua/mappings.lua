require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>q", ":q<cr>", { desc = "Exit" })

-- nvim

map("n", "<leader>r", ":LspRestart<cr>", { desc = "LSP restart" })
map("n", "<leader>s", ':vsplit<cr>', { desc = "Vertical split" })
map("n", "<leader>S", ':split<cr>', { desc = "Horizontal split" })
map("n", "<C-z>", 'zfi{', { desc = "Wrap/unwrap" })
map("n", "<leader>gg", ':Git<cr>:resize 10 wh<cr>', { desc = "Git status" })

-- code manipulation

map("n", "<leader>v", ":ArgWrap<cr>", { desc = "Wrap/Unwrap" })
map("n", "<leader>yp", 'vi"y', { desc = "Yank inside doublequotes" })
map("n", "<leader>pp", 'vi""_dP', { desc = "Paste inside doublequotes" })
map("n", "<leader>gd", ':Gitsigns diffthis<cr>', { desc = "Git diff" })
map("n", "<leader>gb", ':Telescope git_branches<cr>', { desc = "Git branch" })
map("n", "td", ':Telescope diagnostics<cr>', { desc = "Diagnostics" })
map("n", "ts", ':Telescope lsp_document_symbols<cr>', { desc = "File symbols" })
map("n", "tS", ':Telescope lsp_dynamic_workspace_symbols<cr>', { desc = "All symbols" })
map("n", "tt", ':lua require("neotest").run.run()<cr>', { desc = "Neotest func" })
map("n", "tT", ':lua require("neotest").run.run(vim.fn.expand("%"))<cr>', { desc = "Neotest all funcs" })
map("n", "gd", ':Telescope lsp_definitions<cr>', { desc = "Go to definition" })
map("n", "gi", ':Telescope lsp_implementations<cr>', { desc = "Go to implementations" })
map("n", "gr", ':Telescope lsp_references<cr>', { desc = "Go to references" })
map("n", "<F2>", ':lua vim.lsp.buf.rename("")', { desc = "Buf rename" })

-- code manipulation - Go specific

map("n", "tf", ':GoTestFunc<cr>', { desc = "Run test" })
map("n", "ta", ':GoTest<cr>', { desc = "Run all tests" })
map("n", "<leader>ft", function()
  local currentFile = vim.api.nvim_buf_get_name(0)
  local isTestFile = string.match(currentFile, "_test.go$")
  local fileToOpen
  if isTestFile then
    fileToOpen = string.gsub(currentFile, "_test", "")
  else
    fileToOpen = string.sub(currentFile, 1, string.len(currentFile) - 3) .. "_test.go"
  end
  vim.cmd.edit(fileToOpen)
end, { desc = "Run all tests" })

-- external calls

map("n", "<C-e>", ":silent !nohup alacritty&<cr>", { desc = "Alacritty" })

-- movement

map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "<C-k>", "5k")

-- visual

map({ "v" }, "<C-c>", '"+y', { desc = "Copy to clipboard" })
map({ "v" }, "<C-r>", '"hy:.,$s/<C-r>h//gc<left><left><left>', { desc = "Find and replace" })
