require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>q", ":q<cr>", { desc = "Exit" })

-- nvim

map("n", "<leader>r", ":lsp restart<cr>", { desc = "LSP restart" })
map("n", "<leader>s", ':vsplit<cr>', { desc = "Vertical split" })
map("n", "<leader>S", ':split<cr>', { desc = "Horizontal split" })
map("n", "<C-z>", 'zfi{', { desc = "Fold inner block" })
map("n", "<leader>gg", ':Git<cr>:resize 10<cr>', { desc = "Git status" })

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
map("n", "to", ':lua require("neotest").output_panel.open()<cr>', { desc = "Neotest output panel" })
map("n", "toc", ':lua require("neotest").output_panel.clear()<cr>', { desc = "Neotest output panel clear" })
map("n", "tT", ':lua require("neotest").run.run(vim.fn.expand("%"))<cr>', { desc = "Neotest all funcs" })
map("n", "gd", ':Telescope lsp_definitions<cr>', { desc = "Go to definition" })
map("n", "gi", ':Telescope lsp_implementations<cr>', { desc = "Go to implementations" })
map("n", "gr", ':Telescope lsp_references<cr>', { desc = "Go to references" })
map("n", "<F2>", vim.lsp.buf.rename, { desc = "LSP rename" })

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
end, { desc = "Jump to tests/implementation" })

-- open tmux session and set the socket path into @nvim_socket
-- this var can then be fetched with 'tmux show-options -qv -t "$ACTIVE_PANE" @nvim_socket'
-- this is useful for alacritty to call nvr to open a file when clicking on a file
map("n", "<C-e>", function()
  local project_root = vim.uv.cwd() or "."
  local servername = vim.v.servername
  local escaped_root = vim.fn.shellescape(project_root)

  -- 1. Create the pane and capture its ID
  local cmd = string.format("tmux split-window -v -c %s -P -F '#{pane_id}'", escaped_root)
  local handle = io.popen(cmd)
  local new_pane_id = handle:read("*a"):gsub("%s+", "")
  handle:close()

  -- 2. Store the socket in a custom tmux option (@nvim_socket)
  if new_pane_id ~= "" then
    local set_opt = string.format("tmux set-option -t %s @nvim_socket '%s'", new_pane_id, servername)
    os.execute(set_opt)
  end
end, { desc = "Tmux split with queryable metadata" })

map("n", "gG", function()
  -- 1. Get the remote URL
  local remote = vim.fn.system("git remote get-url origin"):gsub("%s+", "")
  if remote == "" or remote:find("fatal") then
    print("Error: No git remote 'origin' found.")
    return
  end

  -- 2. Generic SSH to HTTPS transformation
  -- Handles git@host.com:user/repo.git -> https://host.com/user/repo
  local url = remote
  if url:match("^git@") then
    url = url:gsub(":", "/", 1):gsub("git@", "https://")
  end
  url = url:gsub("%.git$", "")

  -- 3. Detect the host to determine the URL structure
  -- GitLab uses /-/blob/, most others (GitHub, Gitea) use /blob/
  local separator = "/blob/"
  if url:find("gitlab") then
    separator = "/-/blob/"
  end

  -- 4. Get Git metadata
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%s+", "")
  local file_path = vim.fn.system("git ls-files --full-name " .. vim.fn.shellescape(vim.fn.expand("%"))):gsub("^%s+", ""):gsub("%s+$", "")
  
  if file_path == "" then
    print("Error: File is not tracked by git.")
    return
  end

  -- 5. Build the final URL
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local final_url = string.format("%s%s%s/%s#L%s", url, separator, branch, file_path, line)

  -- 6. Open the URL
  if vim.ui.open then
    vim.ui.open(final_url)
  else
    local opener = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.jobstart({ opener, final_url })
  end
  
  print("Opening " .. (url:match("([^/]+)$") or "repository") .. " at line " .. line)
end, { desc = "Open current line in web interface" })

-- movement

map({ "n", "v" }, "<C-j>", "5j")
map({ "n", "v" }, "<C-k>", "5k")

-- visual

map({ "v" }, "<C-c>", '"+y', { desc = "Copy to clipboard" })
map({ "v" }, "<C-r>", '"hy:s/<C-r>h//gc<left><left><left>', { desc = "Find and replace" })
