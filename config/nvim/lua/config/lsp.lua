-- LSP optimizations for faster startup

-- gopls: disable unnecessary analysis to speed up indexing
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParams = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
      analyses = {
        unusedparams = false,
        unusedwrite = false,
        shadow = false,
      },
      staticcheck = false,
      usePlaceholders = false,
      completeUnimported = true,
      build = {
        incrementalModuleResolution = true,
        buildalldeps = false,
      },
      vulncheck = "WhenBuild",
    },
  },
})
