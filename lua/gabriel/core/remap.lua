vim.g.mapleader = ' '

local keymap = vim.keymap

keymap.set('n', '<leader>ee', ':Yazi<cr>')

keymap.set('t', '<ESC>', '<C-\\><C-n>', {noremap = true})

keymap.set('n', '<Leader>te', '', {
  noremap = true,
  silent = true,
  callback = function()
    local term_buf = nil

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
        term_buf = buf
        break
      end
    end

    if term_buf then
      -- Go to the window showing the terminal buffer
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == term_buf then
          vim.api.nvim_set_current_win(win)
          vim.cmd("startinsert")
          return
        end
      end
      -- If terminal buffer exists but not visible, open it at bottom
      vim.cmd("botright split")
      vim.cmd("resize 10")
      vim.cmd("buffer " .. term_buf)
      vim.cmd("startinsert")
    else
      -- No terminal exists, create a new one at bottom
      vim.cmd("botright split")
      vim.cmd("resize 10")
      vim.cmd("terminal")
      vim.cmd("startinsert")
    end
  end
})

keymap.set("n", "gr", vim.lsp.buf.references)

keymap.set("n", "K", vim.lsp.buf.hover)
keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

keymap.set("n", "<leader>ex", ":NvimTreeToggle<cr>")
-- Paste from clipboard
keymap.set("n", "<leader>v", '"+p', { noremap = true, silent = true })
keymap.set("v", "<leader>v", '"+p', { noremap = true, silent = true })

-- Copy to clipboard
keymap.set("n", "<leader>c", '"+y', { noremap = true, silent = true })
keymap.set("v", "<leader>c", '"+y', { noremap = true, silent = true })


-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

keymap.set("n", "<F2>", function()
    vim.lsp.buf.rename()
   end)

keymap.set("n", "<F3>", ":Telescope colorscheme<cr>")
