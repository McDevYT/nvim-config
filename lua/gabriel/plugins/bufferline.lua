return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
          },
        },
        separator_style = "thin",
      },
    })

    local map = vim.keymap.set
    map("n", "<S-l>", ":BufferLineCycleNext<CR>")
    map("n", "<S-h>", ":BufferLineCyclePrev<CR>")
    map("n", "<leader>bd", ":bdelete<CR>")
  end,
}
