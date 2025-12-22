
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
            text_align = "center"
          }
        },
        show_buffer_close_icons = false,
        show_close_icon = true,
        separator_style = "thin",
        enforce_regular_tabs = true,
      },
    })

    local map = vim.keymap.set
    map("n", "<S-l>", ":BufferLineCycleNext<CR>")
    map("n", "<S-h>", ":BufferLineCyclePrev<CR>")
    map("n", "<leader>bd", ":bdelete<CR>")
  end,
}
