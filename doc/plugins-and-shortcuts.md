# Plugins & Shortcuts

A reference for the **active** plugins and the **basic keyboard shortcuts** in this
kickstart-based Neovim config. Everything below is what's enabled by default in
`init.lua`.

> **Leader key** is `<Space>` (both `mapleader` and `maplocalleader`).
> Wherever you see `<leader>`, press the spacebar.

---

## Active Plugins

These are installed via `vim.pack.add` and active out of the box.

| Plugin | Purpose |
|---|---|
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Auto-detects indentation (tabs vs spaces) per file |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons (only loaded if `vim.g.have_nerd_font = true`) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git change signs in the gutter (`+` `~` `_`) and hunk utilities |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup that shows pending keybindings as you type |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme (active theme) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlights `TODO`, `FIXME`, `HACK`, etc. in comments |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim) | Collection — this config uses `mini.ai`, `mini.surround`, `mini.statusline` |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library (Telescope dependency) |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, symbols, etc. |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | Routes `vim.ui.select` through Telescope |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Faster fuzzy sorting (only if `make` is available) |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress notifications in the corner |
| [nvim-lspconfig + mason](https://github.com/neovim/nvim-lspconfig) | LSP setup and automatic server/tool installation |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter runner (format-on-save, `stylua` for Lua) |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletion engine (uses the `default` preset) |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting, indentation, text objects (`main` branch) |

### mini.nvim modules in use
- **mini.ai** — extended around/inside text objects (e.g. `va)`, `ci'`, `yiiq`)
- **mini.surround** — add/delete/replace surroundings (e.g. `saiw)`, `sd'`, `sr)'`)
- **mini.statusline** — the status line at the bottom

### Disabled / optional plugins
These are commented out at the bottom of `init.lua` — uncomment to enable:
- `kickstart.plugins.debug` — DAP debugging
- `kickstart.plugins.indent_line` — indent guides
- `kickstart.plugins.lint` — linting
- `kickstart.plugins.autopairs` — auto-close brackets/quotes
- `kickstart.plugins.neo-tree` — file explorer sidebar
- `kickstart.plugins.gitsigns` — adds gitsigns hunk keymaps (`<leader>h…`)

---

## Basic Shortcuts

### General / Editing
| Shortcut | Action |
|---|---|
| `<Space>` | Leader key |
| `<Esc>` | Clear search highlight |
| `<leader>q` | Open diagnostic quickfix (location) list |
| `<leader>f` | Format the current buffer (conform) |

### Window navigation
| Shortcut | Action |
|---|---|
| `<C-h>` | Move focus to the left window |
| `<C-l>` | Move focus to the right window |
| `<C-j>` | Move focus to the lower window |
| `<C-k>` | Move focus to the upper window |

### Terminal
| Shortcut | Action |
|---|---|
| `:terminal` / `:vsplit \| term` | Open built-in terminal (no plugin) |
| `<Esc><Esc>` | Exit terminal mode (back to normal mode) |

### Search (Telescope) — `<leader>s…`
| Shortcut | Action |
|---|---|
| `<leader>sh` | Search **H**elp tags |
| `<leader>sk` | Search **K**eymaps |
| `<leader>sf` | Search **F**iles |
| `<leader>ss` | **S**elect Telescope builtin pickers |
| `<leader>sw` | Search current **W**ord under cursor |
| `<leader>sg` | Search by **G**rep (live grep) |
| `<leader>sd` | Search **D**iagnostics |
| `<leader>sr` | Search **R**esume (reopen last picker) |
| `<leader>s.` | Search recent files (oldfiles) |
| `<leader>sc` | Search **C**ommands |
| `<leader>sn` | Search **N**eovim config files |
| `<leader>s/` | Live grep in open files |
| `<leader>/` | Fuzzy-find in the current buffer |
| `<leader><leader>` | Find existing buffers |

### LSP (active when an LSP attaches to the buffer)
| Shortcut | Action |
|---|---|
| `grd` | **G**oto **D**efinition |
| `grr` | **G**oto **R**eferences |
| `gri` | **G**oto **I**mplementation |
| `grt` | **G**oto **T**ype definition |
| `grn` | **R**ename symbol (Neovim built-in default) |
| `gra` | Code **A**ction (Neovim built-in default) |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<C-t>` | Jump back after a goto |

### Completion (blink.cmp — `default` preset)
| Shortcut | Action |
|---|---|
| `<C-y>` | Accept the selected completion |
| `<C-Space>` | Open menu / open docs |
| `<C-n>` / `<C-p>` | Select next / previous item (also `<Up>`/`<Down>`) |
| `<C-e>` | Hide the completion menu |
| `<C-k>` | Toggle signature help |
| `<Tab>` / `<S-Tab>` | Jump to right/left of a snippet expansion |

### mini.ai / mini.surround text objects
| Example | Action |
|---|---|
| `va)` | **V**isually select **A**round `)` |
| `ci'` | **C**hange **I**nside `'` quotes |
| `saiw)` | **S**urround **A**dd **I**nner **W**ord with `)` |
| `sd'` | **S**urround **D**elete `'` quotes |
| `sr)'` | **S**urround **R**eplace `)` with `'` |

---

## Discovering more

- Press `<Space>` and wait — **which-key** lists what's available.
- `<leader>sk` — fuzzy-search **all** keymaps via Telescope.
- `:help <topic>` — e.g. `:help telescope`, `:help gitsigns`, `:help mini.ai`.

> All shortcuts are defined in `init.lua`. This doc reflects the default config;
> if you customize keymaps, update this file too.
