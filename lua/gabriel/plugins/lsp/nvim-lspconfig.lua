return {
"neovim/nvim-lspconfig",
dependencies = { "williamboman/mason-lspconfig.nvim", "jose-elias-alvarez/typescript.nvim" },
config = function()
local lspconfig = require("lspconfig")
local typescript = require("typescript")

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

  -- TS/TSX server with strict checking
  typescript.setup({
    server = {
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = { includeInlayParameterNameHints = "all" },
        },
        javascript = {
          inlayHints = { includeInlayParameterNameHints = "all" },
        },
      },
    },
  })

  -- Other servers
  local servers = { "html", "cssls", "emmet_ls", "lua_ls" }
  for _, server in ipairs(servers) do
    local opts = { capabilities = capabilities }
    if server == "lua_ls" then
      opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
    end
    lspconfig[server].setup(opts)
  end
end,

}
