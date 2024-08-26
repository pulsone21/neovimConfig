-- define all LSP you want to get installed and configured.
-- You can use the same convention as if you would do lspconfig[server].setup
local M = {

  -- lua language server
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },

  sqls = {
    filetypes = { 'sql' },
    settings = {},
  },

  -- python lsp
  pyright = {
    filetypes = { 'python' },
    settings = {},
  },

  -- dockerfiles language server
  dockerls = {
    settings = {},
    filetypes = { 'dockerfile', 'Dockerfile' },
  },

  -- golang language server
  -- gopls = {
  --   filetypes = { 'go', 'gomod', 'gowork', 'gotempl' },
  --   settings = {
  --     gopls = {
  --       usePlaceholders = true,
  --       completeUnimported = true,
  --       analyses = {
  --         unusedparams = true,
  --       },
  --       staticcheck = true,
  --       hints = {
  --         assignVariableTypes = true,
  --         compositeLiteralFields = true,
  --         compositeLiteralTypes = true,
  --         constantValues = true,
  --         functionTypeParameters = true,
  --         parameterNames = true,
  --         rangeVariableTypes = true,
  --       },
  --       gofumpt = true,
  --     },
  --   },
  -- },
}
return M
