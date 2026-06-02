vim.pack.add { 'https://github.com/rose-pine/neovim' }
require('rose-pine').setup ({
  variant = "main",
  styles = {
    italic = false,
  },
})

vim.cmd.colorscheme 'rose-pine'
