vim.pack.add { 'https://github.com/NeogitOrg/neogit' }

require('neogit').setup {
  disable_hint = true,
  graph_style = 'unicode',
  kind = 'tab',
}

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Open Neogit' })
