return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    {
      "neovim/nvim-lspconfig",
      dependencies = { "williamboman/mason-lspconfig.nvim" },
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = false

        -- Configure servers (override defaults if needed)
        vim.lsp.config("ts_ls", {
          capabilities = capabilities,
        })

        vim.lsp.config("html", {
          capabilities = capabilities,
        })

        vim.lsp.config("cssls", {
          capabilities = capabilities,
        })

        vim.lsp.config("emmet_ls", {
          capabilities = capabilities,
        })

        vim.lsp.config("terraformls", {
          capabilities = capabilities,
        })

        -- Enable all of them
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("html")
        vim.lsp.enable("cssls")
        vim.lsp.enable("emmet_ls")
        vim.lsp.enable("spyglass_language_server")
        vim.lsp.enable("terraformls")
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local types = require("cmp.types")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),

      sources = {
        {
          name = "nvim_lsp",
          entry_filter = function(entry)
            -- Remove ALL snippet items from LSP
            return entry:get_kind() ~= types.lsp.CompletionItemKind.Snippet
          end,
        },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
}
