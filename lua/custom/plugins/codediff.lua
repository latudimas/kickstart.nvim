-- VSCode style diff viewer. Neogit auto-detects it for its diff popup.
-- Inside a CodeDiff tab press `g?` to see all its keymaps.
vim.pack.add { 'https://github.com/esmuellert/codediff.nvim' }

require('codediff').setup {}

vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff<cr>', { desc = '[G]it [D]iff working tree' })
vim.keymap.set('n', '<leader>gs', '<cmd>CodeDiff --staged<cr>', { desc = '[G]it diff [S]taged' })
vim.keymap.set('n', '<leader>gm', '<cmd>CodeDiff master...<cr>', { desc = '[G]it diff branch vs [M]aster' })
vim.keymap.set('n', '<leader>gf', '<cmd>CodeDiff file HEAD<cr>', { desc = '[G]it diff current [F]ile vs HEAD' })
vim.keymap.set('n', '<leader>gh', '<cmd>CodeDiff history<cr>', { desc = '[G]it [H]istory' })
vim.keymap.set('n', '<leader>gH', '<cmd>CodeDiff history %<cr>', { desc = '[G]it [H]istory of current file' })
vim.keymap.set('x', '<leader>gh', ':CodeDiff history<cr>', { desc = '[G]it [H]istory of selected lines' })
