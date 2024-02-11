return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- visual improvements
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local srcConfig = require 'jo.plugins.lsp.config.cmp_config'
    local luasnip = require 'luasnip'
    local lspKind = require 'lspkind'

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        cimpleteopt = 'menu,menuone,noinsert',
      },

      -- mapping for the suggestion popup
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      -- sources where snippeds are loaded, can be configured in "jo/plugins/lsp/config/cmp_config.lua"
      sources = srcConfig,

      -- formating options, adds vscode like icons to methods, function etc.
      -- the error can be ignored, the fields variable has a default settings
      formatting = {
        expandable_indicator = false,
        format = lspKind.cmp_format {
          maxwidth = 50,
          ellipsis_char = '...',
        },
      },
    }
  end,
}
