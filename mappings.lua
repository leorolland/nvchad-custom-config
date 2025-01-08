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
    ["<S-h>"] = {'<C-w>h'},
    ["<S-j>"] = {'<C-w>j'},
    ["<S-k>"] = {'<C-w>k'},
    ["<S-l>"] = {'<C-w>l'},
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
    ["tt"] = {':lua require("neotest").run.run()<cr>'},
    ["tT"] = {':lua require("neotest").run.run(vim.fn.expand("%"))<cr>'},
    ["gd"] = {':Telescope lsp_definitions<cr>'},
    ["gi"] = {':Telescope lsp_implementations<cr>'},
    ["gr"] = {':Telescope lsp_references<cr>'},
    ["<F2>"] = {':lua vim.lsp.buf.rename("")'},
    ["<leader>s"] = {':vsplit<cr>'},
    ["<leader>S"] = {':split<cr>'},
    ["<leader>ft"] = {
      function()
        local currentFile = vim.api.nvim_buf_get_name(0)
        -- local isTestFile = string.match(currentFile, "_test.go$")

        local fileToOpen
        if isTestFile then
          fileToOpen = string.gsub(currentFile, "_test", "")
        else
          fileToOpen = string.sub(currentFile, 1, string.len(currentFile) - 3) .. "_test.go"
        end

        vim.cmd.edit(fileToOpen)
      end, { desc = "Switch to test/code" }
    },
    ["<leader>gg"] = {':Git<cr>:resize 10 wh<cr>'},
    ["<C-z>"] = {'zfi{'},
  },
  v = {
    ["<C-j>"] = {"5j"},
    ["<C-k>"] = {"5k"},
    ["<C-h>"] = {"b"},
    ["<C-l>"] = {"w"},
    ["<S-h>"] = {'<C-w>h'},
    ["<S-j>"] = {'<C-w>j'},
    ["<S-k>"] = {'<C-w>k'},
    ["<S-l>"] = {'<C-w>l'},
    ["<C-c>"] = {'"+y'},
    ["<C-r>"] = {'"hy:.,$s/<C-r>h//gc<left><left><left>'},
    ["<leader>p"] = {'"_dP'},
    ["<leader>fp"] = {':lua require("spectre").open_file_search({select_word=true})<CR>'},
    ["<leader>fP"] = {':lua require("spectre").open_visual({select_word=true})<CR>'},
  }

}

return M
