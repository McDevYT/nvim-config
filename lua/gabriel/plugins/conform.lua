return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
          timeout_ms = 5000,
        })
      end,
      desc = "Format file",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },

      terraform = { "terraform_fmt" },
    },

    -- Keep formatting reliable in monorepos: run Prettier from the nearest
    -- directory that contains a Prettier config (or package.json).
    formatters = {
      prettier = {
        cwd = function(_, ctx)
          return vim.fs.root(ctx.buf, {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.yaml",
            ".prettierrc.yml",
            "prettier.config.js",
            "prettier.config.cjs",
            "package.json",
          }) or vim.fs.dirname(ctx.filename)
        end,
      },
    },
  },
}
