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
        capabilities= capabilities,
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
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  }
