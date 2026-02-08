return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = { "prettier", "stylua", "black", "shfmt", "eslint_d" },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local servers = {
        ts_ls = {},
        html = {},
        cssls = {},
        emmet_ls = {},
        pyright = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              completion = { callSnippet = "Replace" },
            },
          },
        },
      }

      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable snippet support so servers send data, but we filter it in CMP later
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server_config = servers[server_name] or {}

            server_config.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

            server_config.on_attach = function(client, bufnr)
              local disable_formatting = {
                ts_ls = true,
                html = true,
                cssls = true,
                lua_ls = true,
              }
              if disable_formatting[client.name] then
                client.server_capabilities.documentFormattingProvider = false
              end
            end

            require("lspconfig")[server_name].setup(server_config)
          end,
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. Diagnostic Config
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      })

      -- 2. AUTOMATIC INDENTATION SYNC (Reads .prettierrc via Node)
      -- This ensures Neovim tabs match Prettier config exactly, per file.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("PrettierIndentation", { clear = true }),
        pattern = "*",
        callback = function()
          -- Only run for web-related types
          local filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "css",
            "scss",
            "json",
            "html",
            "yaml",
            "markdown",
          }
          if not vim.tbl_contains(filetypes, vim.bo.filetype) then
            return
          end

          local file_path = vim.api.nvim_buf_get_name(0)
          if file_path == "" then
            return
          end

          -- Query Prettier for the config of this specific file
          local cmd = string.format(
            'node -e \'const p = require("prettier"); p.resolveConfig("%s").then(c => console.log(JSON.stringify(c)))\'',
            file_path
          )

          vim.fn.jobstart(cmd, {
            on_stdout = function(_, data)
              if data and data[1] and data[1] ~= "" and data[1] ~= "null" then
                local success, config = pcall(vim.json.decode, data[1])
                if success and config then
                  if config.tabWidth then
                    vim.bo.tabstop = config.tabWidth
                    vim.bo.shiftwidth = config.tabWidth
                    vim.bo.softtabstop = config.tabWidth
                  end
                  if config.useTabs ~= nil then
                    vim.bo.expandtab = not config.useTabs
                  end
                end
              end
            end,
            stdout_buffered = true,
          })
        end,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Custom snippets (like color-mix)
      luasnip.add_snippets("css", {
        luasnip.snippet("color-mix", {
          luasnip.text_node("color-mix(in srgb, "),
          luasnip.insert_node(1, "base-color"),
          luasnip.text_node(", "),
          luasnip.insert_node(2, "mix-color"),
          luasnip.text_node(" "),
          luasnip.insert_node(3, "percentage"),
          luasnip.text_node("%)"),
        }),
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            -- Filter out annoying LSP snippets (Keep this!)
            entry_filter = function(entry, ctx)
              if entry:get_kind() == 15 then
                return false
              end
              return true
            end,
          },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
