return {

  'olexsmir/gopher.nvim',

  ft = 'go',
  config = function()
    require('gopher').setup {
      commands = {
        go = 'go',
        gomodifytags = 'gomodifytags',
        gotests = '~/go/bin/gotests', -- also you can set custom command path
        impl = 'impl',
        iferr = 'iferr',
      },
    }
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    local map = function(keys, func, desc)
      if desc then
        desc = 'Gopher: ' .. desc
        opts.desc = desc
      end
      keymap.set('n', keys, func, opts)
    end
    map('<leader>lgtaj', ':GoTagAdd json  %<CR>', '[G]o [t]ag [a]dd [j]son')
    map('<leader>lgtay', ':GoTagAdd yaml  %<CR>', '[G]o [t]ag [a]dd [y]aml')
    map('<leader>lgtrj', ':GoTagRm json  %<CR>', '[G]o [t]ag [r]emove [j]son')
    map('<leader>lgtry', ':GoTagRm yaml  %<CR>', '[G]o [t]ag [r]emove [y]aml')

    map('<leader>lgm', ':GoMod %<CR>', '[G]o [M]od [T]idy')

    local whichKey = require 'which-key'
    whichKey.add {
      { '<leader>l', group = '[L]uange specific functions', mode = { 'n' } },
      { '<leader>lg', group = '[G]o functions', mode = { 'n' } },
      { '<leader>lgm', name = '[G]o [M]od Tidy', mode = { 'n' } },
      { '<leader>lgt', group = '[G]o [T]ag functions', mode = { 'n' } },
      { '<leader>lgta', name = '[G]o [T]ag [A]dd', mode = { 'n' } },
      { '<leader>lgtr', name = '[G]o [T]ag [R]emove', mode = { 'n' } },
      { '<leader>lgtaj', name = '[G]o [T]ag [A]dd [J]son', mode = { 'n' } },
      { '<leader>lgtrj', name = '[G]o [T]ag [R]emove [J]son', mode = { 'n' } },
      { '<leader>lgtay', name = '[G]o [T]ag [A]dd [Y]aml', mode = { 'n' } },
      { '<leader>lgtry', name = '[G]o [T]ag [R]emove [Y]aml', mode = { 'n' } },
    }
  end,
  build = function()
    vim.cmd [[silent! GoInstallDeps]]
  end,
}
