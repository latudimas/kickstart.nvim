# Telescope migration: general search/navigation

## Scope

- Branch `fff-test`, config baseline `cdaf85e`.
- Installed sources inspected: Telescope `7d32479`, telescope-ui-select `6e51d7d`, FFF `d1c7dd4`.
- fzf-lua is **not installed**; its details come from upstream docs, not source inspection.
- Covers general search/navigation and `vim.ui.select`; LSP mappings excluded.
- Already on FFF: `<leader>sf`, `<leader>sg`, `<leader>sw`, `<leader>sn`.
- Investigation only, not approval to change mappings or remove plugins.

## Current Telescope usage

- `init.lua` (search/navigation section) calls `telescope.builtin` directly; no custom finders.
- Local customization: mappings, options, themes, `fzf` + `ui-select` extensions.
- `telescope-fzf-native` only speeds up sorting; it doesn't call the `fzf` binary or supply data.
- Mappings that still use Telescope:
  - `<leader>sh` → `help_tags`: runtime help tags, opens topic.
  - `<leader>sk` → `keymaps`: global + buffer-local keymaps.
  - `<leader>ss` → `builtin`: list of Telescope pickers.
  - `<leader>sd` → `diagnostics`: jump to diagnostic.
  - `<leader>sr` → `resume`: reopens last Telescope picker.
  - `<leader>s.` → `oldfiles`: session files + `vim.v.oldfiles`, excludes current file (not frecency).
  - `<leader>sc` → `commands`: runs no-arg commands, else fills the cmdline.
  - `<leader><leader>` → `buffers`: listed buffers, including unsaved.
  - `<leader>/` → `current_buffer_fuzzy_find`: current buffer lines incl. unsaved text; dropdown, `winblend = 10`, no preview.
  - `<leader>s/` → `live_grep` with `grep_open_files = true`: runs `rg` on open buffers' paths, so it searches disk, not unsaved text.
  - `vim.ui.select` → `telescope-ui-select` (dropdown theme).

## Can FFF replace these?

- **Mostly no.** FFF's picker only shows its own file index or grep results; it has no API for a custom item list.
- FFF source findings:
  - `main.lua` has `resume()` (restores last FFF file/grep picker; empty-query close keeps the old snapshot). The README list of APIs leaves it out.
  - `find_files` `renderer`/`on_submit` change display and selection, not the candidate source.
  - `search_manager.lua` sends queries straight to file search or grep; no `items`/`finder` hook.
  - `open_with_callback` receives file-search results; it can't supply custom items.
  - `fuzzy.lua` exports `set_provider_items`, `fuzzy`, `fuzzy_matched_indices`, but they are `nil` at runtime. Don't use them.
- Per feature:
  - Resume (`sr`): **direct** with `require('fff').resume()`, but it only resumes FFF pickers.
  - Open-files grep (`s/`): **custom adapter** that limits grep to exactly the open files; check ignore rules, roots, escaping, pagination.
  - Current buffer (`/`): **none**; needs an in-memory list picker; disk grep loses unsaved text.
  - Buffers, oldfiles, help, keymaps, commands, diagnostics: **custom generic picker needed**.
  - Picker list (`ss`): **retire or redefine**.
  - `vim.ui.select`: **no adapter**; needs a generic picker that handles formatting, callback item/index, and `nil` on cancel.
- Making FFF do all of this means forking its pipeline or writing a separate picker; it isn't a config change.

## Telescope vs fzf-lua

- **Matching**: Telescope matches in Lua (faster with fzf-native); fzf-lua sends items to the external `fzf` binary.
- **Speed**: fzf-lua stays fast on very large lists; Telescope can lag. Small difference here, because FFF already handles files/grep.
- **Dependencies**: Telescope needs `plenary.nvim` (+ `make` for fzf-native); fzf-lua needs the `fzf` binary (`brew install fzf`), optionally `rg`/`fd`/`bat`.
- **Built-in pickers**: Telescope ~50; fzf-lua ~90+ (adds tags, DAP, highlights, autocmds, jumps/changes, spell…).
- **Extensions**: Telescope has a large ecosystem; fzf-lua builds more in and has fewer extensions.
- **`vim.ui.select`**: Telescope needs `telescope-ui-select`; fzf-lua has `register_ui_select()` built in.
- **Custom pickers**: easy in both (`pickers.new` vs `fzf_exec` with a list or a shell command).
- **UI**: Telescope uses native Neovim prompt/results/preview windows; fzf-lua shows an fzf terminal UI, so some keys behave like fzf rather than Vim.
- **Maintenance**: Telescope is stable, with slower development; fzf-lua is very actively maintained.
- fzf-lua equivalents for current mappings:
  - `sh` → `helptags`; `sk` → `keymaps`; `ss` → `builtin`; `sr` → `resume`.
  - `sd` → `diagnostics_workspace` / `diagnostics_document`.
  - `s.` → `oldfiles` (check the option that includes current-session files).
  - `sc` → `commands`; `<leader><leader>` → `buffers`.
  - `/` → `blines` (buffer lines, includes unsaved text).
  - `s/` → `lines` (all open buffers' lines, includes unsaved text; different from Telescope's disk grep).
  - `vim.ui.select` → `register_ui_select()`.
- **Using fzf-lua with FFF**: works side by side (FFF for files/grep, fzf-lua for the rest). No integration either way; feeding FFF results into fzf would re-rank them and lose FFF's typo tolerance, frecency, and git awareness.
- Other options: `mini.pick` + `mini.extra` (pure Lua, likely already installed via mini.nvim), `snacks.picker`.

## Direction

1. Lowest-risk next step: map `sr` to FFF `resume()` if resume should cover FFF only.
2. Keep Telescope until the remaining behavior has tested replacements.
3. Target setup: FFF for files/content + one general picker (Telescope, fzf-lua, or mini.pick) for Neovim lists.
4. Switch to fzf-lua mainly for active maintenance, built-in `ui-select`, and more pickers, not for speed.
5. Before removing Telescope, test: unnamed/modified buffers, files from other project roots, exact file scope for `s/`, cancel behavior, split/tab open, resume with empty and non-empty queries.

## Source map

- Plugin paths are relative to `stdpath('data')/site/pack/core/opt/`.
- Config: `init.lua`, search/navigation section.
- Telescope: `lua/telescope/builtin/{__internal,__files,__diagnostics}.lua`, `lua/telescope/{pickers,finders,sorters}.lua`, `lua/telescope/actions/init.lua`.
- UI select: `telescope-ui-select.nvim/lua/telescope/_extensions/ui-select.lua`.
- FFF: `lua/fff/main.lua`, `lua/fff/fuzzy.lua`, `lua/fff/picker_ui/{picker_ui,search_manager,list_renderer}.lua`.
- Upstream: https://github.com/dmtrKovalenko/fff#neovim-plugin, https://github.com/ibhagwan/fzf-lua
- Evidence: static source reading + headless API-presence checks; adapters not built or tested. Recheck plugin revisions before relying on internal APIs.
