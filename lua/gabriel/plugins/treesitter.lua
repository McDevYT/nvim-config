
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua", "python", "javascript", "typescript", "c", "cpp","json","bash","tsx","html","css" }, -- languages to install
      highlight = {
        enable = true,              -- enable syntax highlighting
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },   -- optional: auto indentation
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    }
  end,
}
