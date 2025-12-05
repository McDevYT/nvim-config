return {
  -- Mason: installs language servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "html",
          "cssls",
          "emmet_ls",
          "lua_ls",
        }
      })
    end,
  },

{
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

},
  -- Autocomplete engine (nvim-cmp)
  {
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
    vim.lsp.config("tsserver", {
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

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- Enable all of them
    vim.lsp.enable("tsserver")
    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
    vim.lsp.enable("emmet_ls")
    vim.lsp.enable("lua_ls")
  end,
},
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
