vim.pack.add { 'https://github.com/OXY2DEV/markview.nvim' }

require('markview').setup {
  preview = {
    icon_provider = 'devicons',
  },
}

vim.keymap.set('n', '<leader>tm', '<cmd>Markview toggle<cr>', { desc = '[T]oggle [M]arkview preview' })
