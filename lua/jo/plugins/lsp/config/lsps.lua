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

  -- golang language server
  gopls = {
    filetypes = { 'go', 'gomod', 'gowork', 'gotempl' },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },
}

return M
