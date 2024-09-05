return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wK = require 'which-key'
    wK.add {
      { '<leader>fd', desc = '[F]ile [D]elete file/directory' },
      { '<leader>fn', desc = '[F]ile [N]ew file' },
      { '<leader>fr', desc = '[F]ile [R]ename file/directory' },
      { '<leader>fc', desc = '[F]ile [C]reate directory' },
    }
  end,
  opts = {
    -- your configuration comes here
    -- TODO: Add default groups in here
    -- there are some configs in "./lsp/lspconfig.lua" defined
  },
}
