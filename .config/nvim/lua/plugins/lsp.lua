return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "css_variables",
          "eslint",
          "emmet_language_server",
          "lua_ls",
          "jsonls",
          "marksman",
          "solidity",
          "tsserver",
          "unocss",
          "volar",
          "vuels",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.cssls.setup({})
      lspconfig.css_variables.setup({})
      lspconfig.emmet_language_server.setup({})
      lspconfig.eslint.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.marksman.setup({})
      lspconfig.solidity.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.unocss.setup({})
      lspconfig.volar.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      })
      lspconfig.vuels.setup({})
    end,
  },
}
