return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    local lspConfig = require 'lspconfig'

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    -- creating the on attach function
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      -- make a convient key mapping function
      local map = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
          opts.desc = desc
        end
        keymap.set('n', keys, func, opts)
      end

      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', function()
        vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
      end, '[C]ode [A]ction')

      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      map('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- which-key key chains
    local whichKey = require 'which-key'

    -- register normal mode key chains
    whichKey.add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>g', group = '[G]it' },
      { '<leader>h', group = 'Git [H]unk' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>l', group = '[L]sp' },
    }

    -- register visual mode key chains
    whichKey.add({
      { '<leader>', name = 'VISUAL <leader>' },
    }, { mode = 'v' })

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- getting all lsp server which are configuered
    local requiredLsps = require 'jo.plugins.lsp.config.lsps'

    -- dont know why but added go specific stuff directly here....
    lspConfig.gopls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git'),
      filetypes = { 'go', 'gomod', 'gowork', 'gotempl' },
      settings = {
        gopls = {
          usePlaceholders = true,
          completeUnimported = true,
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          gofumpt = true,
        },
      },
    }

    for server, config in pairs(requiredLsps) do
      lspConfig[server].setup {
        capabilities = (config.capabilities or capabilities),
        on_attach = (config.on_attach or on_attach),
        settings = (config.settings or {}).settings,
        filetypes = (config.filetypes or {}).filetypes,
      }
    end
  end,
}
