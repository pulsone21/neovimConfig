return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local mason = require("mason")
    local mLspConf = require("mason-lspconfig")
    local mTools = require("mason-tool-installer")

    local requiredLsps = require("jo.plugins.lsp.config.lsps") 

mason.setup({
ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

	-- LSPs auto installation
    mLspConf.setup({
ensure_installed = vim.tbl_keys(requiredLsps),
automatic_installation = true,
    })


	-- linter and formatter installations
    mTools.setup({
      ensure_installed = require("jo.plugins.lsp.config.formatter_linters"),
    })
  end,
}
