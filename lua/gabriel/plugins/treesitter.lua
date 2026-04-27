return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "json",
        "bash",
        "tsx",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "query",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = false },
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
    })

    -- Neovim 0.12 + nvim-treesitter markdown injections can crash on fenced code
    -- blocks due to a directive path in plugin queries. Use the runtime markdown
    -- injections query, which is stable with the current core runtime.
    local query_files = vim.api.nvim_get_runtime_file("queries/markdown/injections.scm", true)
    local runtime_query_path = nil
    for _, path in ipairs(query_files) do
      if not path:find("nvim%-treesitter/queries/markdown/injections%.scm", 1, false) then
        runtime_query_path = path
        break
      end
    end

    if runtime_query_path then
      local query_lines = vim.fn.readfile(runtime_query_path)
      if #query_lines > 0 then
        vim.treesitter.query.set("markdown", "injections", table.concat(query_lines, "\n"))
      end
    end
  end,
}
