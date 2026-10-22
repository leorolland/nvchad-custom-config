# Neovim config

Personal Neovim config built on the [NvChad](https://github.com/NvChad/NvChad) starter (v2.5), focused on Go development in tmux.

## Install

1. Install [Neovim 0.12+](https://github.com/neovim/neovim/releases), plus:
   - `git`, `make`, a C compiler and `rg` (ripgrep) — telescope-fzf-native compiles at install time
   - `node`/`npm` — the likec4 language server installs globally on plugin update
   - a [Nerd Font](https://www.nerdfonts.com/) for icons
2. Move any existing config out of the way:
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak   # optional, for a clean start
   ```
3. Clone this repo as your config:
   ```sh
   git clone -b housekeeping git@github.com:leorolland/nvchad-custom-config.git ~/.config/nvim
   ```
   (until this branch is merged into `main`, keep `-b housekeeping`; afterwards the flag is unnecessary)
4. Start `nvim` — lazy.nvim bootstraps itself and installs the plugins pinned in `lazy-lock.json`. Restart nvim once the first sync finishes.
5. Run `:Mason` once — it installs the language servers and tools listed in `ensure_installed` (`lua/plugins/init.lua`): gopls, golangci-lint, yaml, html, css, gofumpt.

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
