return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" }
        }),
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--use-tabs", "false", "--tab-width", "2" }
        }),
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2", "-ci" }
        }),
      },
    })

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end)
  end,
}
