local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<S-k>"] = "",
      ["gd"] = "",
      ["gi"] = "",
      ["gr"] = "",
  }
}

-- Your custom mappings
M.abc = {
  n = {
    ["<leader>q"] = {":q<cr>"},
    ["<C-j>"] = {"5j"},
    ["<C-k>"] = {"5k"},
    ["<C-h>"] = {"b"},
    ["<C-l>"] = {"w"},
    ["<C-S-tab>"] = {"w"},
    ["<C-e>"] = {":silent !nohup alacritty&<cr>"},
    ["<leader>v"] = {':ArgWrap<cr>'},
    ["<leader>yp"] = {'vi"y'},
    ["<leader>pp"] = {'vi""_dP'},
    ["<leader>r"] = {':LspRestart<cr>'},
    ["tf"] = {':GoTestFunc<cr>'},
    ["ta"] = {':GoTest<cr>'},
    ["<leader>gd"] = {':Gitsigns diffthis<cr>'},
    ["<leader>gb"] = {':Telescope git_branches<cr>'},
    ["<leader>fp"] = {':lua require("spectre").open_file_search()CR>'},
    ["<leader>fP"] = {':lua require("spectre").open_visual()<CR>'},
    ["td"] = {':Telescope diagnostics<cr>'},
    ["ts"] = {':Telescope lsp_document_symbols<cr>'},
    ["tS"] = {':Telescope lsp_dynamic_workspace_symbols<cr>'},
    ["gd"] = {':Telescope lsp_definitions<cr>'},
    ["gi"] = {':Telescope lsp_implementations<cr>'},
    ["gr"] = {':Telescope lsp_references<cr>'}
  },
  v = {
    ["<C-j>"] = {"5j"},
    ["<C-k>"] = {"5k"},
    ["<C-h>"] = {"b"},
    ["<C-l>"] = {"w"},
    ["<C-c>"] = {'"+y'},
    ["<C-r>"] = {'"hy:.,$s/<C-r>h//gc<left><left><left>'},
    ["<leader>p"] = {'"_dP'},
    ["<leader>fp"] = {':lua require("spectre").open_file_search({select_word=true})<CR>'},
    ["<leader>fP"] = {':lua require("spectre").open_visual({select_word=true})<CR>'},
  }

}

return M
