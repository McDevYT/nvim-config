return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "ordinal",          -- show buffer numbers
        diagnostics = "nvim_lsp",     -- show LSP diagnostics on buffers
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        show_buffer_close_icons = true,
        show_close_icon = true,
        separator_style = "slant",    -- can be "slant", "padded_slant", "thick", "thin", "slope"
        enforce_regular_tabs = true,
      },
    })

    -- Optional: keymaps for cycling through buffers
    local map = vim.keymap.set
    map("n", "<S-l>", ":BufferLineCycleNext<CR>")
    map("n", "<S-h>", ":BufferLineCyclePrev<CR>")
    map("n", "<leader>bd", ":bdelete<CR>")  -- close buffer
  end,
}
