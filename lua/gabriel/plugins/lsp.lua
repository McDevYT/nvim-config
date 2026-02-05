local function list_contains(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.diagnostic.config({
        underline = true,
        update_in_insert = true,
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = false

      local servers = {
        tsserver = {},
        pyright = {},
        html = {},
        cssls = {},
        emmet_ls = {},
        spyglassmc_language_server = {},
        terraformls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      local mason_lspconfig = require("mason-lspconfig")
      local available_servers = mason_lspconfig.get_available_servers()

      local enabled_servers = {}
      for server_name, _ in pairs(servers) do
        if list_contains(available_servers, server_name) then
          table.insert(enabled_servers, server_name)
        else
          vim.notify(
            ("Skipping LSP '%s' (not supported by mason-lspconfig)"):format(server_name),
            vim.log.levels.WARN
          )
        end
      end

      mason_lspconfig.setup({
        ensure_installed = enabled_servers,
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "prettier",
          "stylua",
          "black",
          "shfmt",

          -- Lint helpers (optional, but useful if you later add nvim-lint)
          "eslint_d",
        },
        run_on_start = true,
      })

      local function on_attach(client, _)
        -- Prefer external formatters (conform.nvim) for these.
        local disable_formatting = {
          tsserver = true,
          pyright = true,
          html = true,
          cssls = true,
          emmet_ls = true,
          lua_ls = true,
        }

        if disable_formatting[client.name] then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end

      for _, server_name in ipairs(enabled_servers) do
        local server_config = servers[server_name] or {}
        vim.lsp.config(server_name, vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, server_config))
      end

      vim.lsp.enable(enabled_servers)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
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
  },
}
