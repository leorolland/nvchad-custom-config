# nvim config

NvChad v2.5 starter with personal customizations, mainly for Go development in tmux.

## Structure

| File | Role |
|---|---|
| `lua/chadrc.lua` | Theme and NvChad UI options |
| `lua/options.lua` | Editor options (`autoread`, Tiltfile detection) |
| `lua/autocmds.lua` | Buffer reload on external edits, Go test folding, diagnostics float |
| `lua/mappings.lua` | Keymaps |
| `lua/plugins/init.lua` | Plugin specs |
| `lua/configs/` | Per-plugin setup (LSP, formatting, tests) |

## Notes

- `<leader>r` restarts LSP clients (`:lsp restart`, nvim 0.12+).
- `autoread` + `checktime` autocmds reload buffers changed outside the editor (opencode, git, code generators) so gopls stays in sync.
- Go formatting is handled by vim-go (gofmt on save); Lua formatting runs through conform with `<leader>fm`.
- LSP servers are enabled in `lua/configs/lspconfig.lua`; binaries come from Mason (`ensure_installed` in `lua/plugins/init.lua`).

`lazy-lock.json` is tracked so plugin versions stay reproducible.
