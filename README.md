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

## What this adds over stock NvChad

- **External-edit sync** — `autoread` + `checktime` autocmds (`FocusGained`, `BufEnter`, `CursorHold`, `TermLeave`) reload buffers changed by opencode, git or code generators so gopls never goes stale; `<leader>r` restarts LSP clients if a session does get corrupted.
- **Go toolchain** — vim-go with gofmt-on-save and `tf`/`ta` test runners, gopls built with `-tags=e2e`, golangci-lint LSP with auto-detection of repo-local versioned binaries, table-test folding in `*_test.go`, `<leader>ft` to jump between code and tests, neotest (`tt`/`to`), and DAP remote-attach to dlv behind Tilt (port 30000).
- **tmux integration** — `<C-e>` opens a tmux pane and publishes the nvim socket so other panes (and alacritty clicks) can drive the editor through `nvr`.
- **LSP/editor extras** — `gd`/`gi`/`gr` through Telescope, diagnostics float on idle, yamlls preloaded with k8s/GitLab CI/helm/kustomize/vector schemas, ArgWrap (`<leader>v`), marks, fugitive (`<leader>gg`), `gG` to open the current line in the GitLab/GitHub web UI.
- **Wider tooling** — treesitter parsers for ~25 languages (go, helm, terraform, yang, jsonnet, ...), Mason `ensure_installed` aligned with the enabled servers.

`lazy-lock.json` is tracked so plugin versions stay reproducible.
