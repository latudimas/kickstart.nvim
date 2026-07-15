vim.pack.add { 'https://github.com/mikavilpas/yazi.nvim' }

require('yazi').setup {
  -- Open yazi automatically when Neovim is started on a directory (e.g. `nvim .`)
  open_for_directories = true,

  -- Optional: floating window size
  floating_window_scaling_factor = 0.9,

  -- Optional: integrate with snacks.nvim picker (if installed)
  -- integrations = {
  --   grep_in_directory = 'snacks.picker',
  -- },
}

-- Open yazi at the current file
vim.keymap.set('n', '<leader>-', '<cmd>Yazi<cr>', { desc = 'Open [Y]azi at current file' })

-- Open yazi at the current working directory
vim.keymap.set('n', '<leader>fy', '<cmd>Yazi cwd<cr>', { desc = '[F]ile [Y]azi (cwd)' })

-- Open yazi with the file under the cursor selected
vim.keymap.set('n', '<leader>Yy', '<cmd>Yazi toggle<cr>', { desc = 'Resume [Y]azi' })
