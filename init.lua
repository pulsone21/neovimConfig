-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'jo.core'
require 'jo.lazy'

local wK = require 'which-key'

wK.add {
  { '<leader>f', group = '[F]ile', icon = '' },
}
