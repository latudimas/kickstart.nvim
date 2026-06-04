-- Linting

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' }, -- Make sure to install `markdownlint` via mason / npm
}

-- To allow other plugins to add linters to require('lint').linters_by_ft,
-- instead set linters_by_ft like this:
-- lint.linters_by_ft = lint.linters_by_ft or {}
-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
--
-- However, note that this will enable a set of default linters,
-- which will cause errors unless these tools are available:
-- {
--   clojure = { "clj-kondo" },
--   dockerfile = { "hadolint" },
--   inko = { "inko" },
--   janet = { "janet" },
--   json = { "jsonlint" },
--   markdown = { "vale" },
--   rst = { "vale" },
--   ruby = { "ruby" },
--   terraform = { "tflint" },
--   text = { "vale" }
-- }
--
-- You can disable the default linters by setting their filetypes to nil:
-- lint.linters_by_ft['clojure'] = nil
-- lint.linters_by_ft['dockerfile'] = nil
-- lint.linters_by_ft['inko'] = nil
-- lint.linters_by_ft['janet'] = nil
-- lint.linters_by_ft['json'] = nil
-- lint.linters_by_ft['markdown'] = nil
-- lint.linters_by_ft['rst'] = nil
-- lint.linters_by_ft['ruby'] = nil
-- lint.linters_by_ft['terraform'] = nil
-- lint.linters_by_ft['text'] = nil

-- Toggle state (global; flips for all buffers)
vim.g.lint_enabled = true

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.g.lint_enabled and vim.bo.modifiable then lint.try_lint() end
  end,
})

-- Clear only nvim-lint's diagnostics (leaves LSP diagnostics intact)
local function clear_lint_diagnostics()
  for _, names in pairs(lint.linters_by_ft) do
    for _, name in ipairs(names) do
      vim.diagnostic.reset(lint.get_namespace(name))
    end
  end
end

vim.api.nvim_create_user_command('LintToggle', function()
  vim.g.lint_enabled = not vim.g.lint_enabled
  if vim.g.lint_enabled then
    lint.try_lint()
    vim.notify('Linting enabled', vim.log.levels.INFO)
  else
    clear_lint_diagnostics()
    vim.notify('Linting disabled', vim.log.levels.WARN)
  end
end, { desc = 'Toggle nvim-lint on/off' })

vim.keymap.set('n', '<leader>tl', '<cmd>LintToggle<CR>', { desc = '[T]oggle [L]inting' })
