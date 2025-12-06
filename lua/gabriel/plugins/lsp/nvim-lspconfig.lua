return {
"neovim/nvim-lspconfig",
dependencies = { "williamboman/mason-lspconfig.nvim", "jose-elias-alvarez/typescript.nvim" },
config = function()

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Live diagnostics (like VS Code)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = true,   -- show diagnostics while typing
      virtual_text = { spacing = 2, prefix = "●" },
      severity_sort = true,
    }
  )
end,

}
