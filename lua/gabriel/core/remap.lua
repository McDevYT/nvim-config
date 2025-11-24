vim.g.mapleader = ' '

local keymap = vim.keymap

keymap.set('n', '<leader>ee', ':Ex<cr>')

keymap.set('t', '<ESC>', '<C-\\><C-n>', {noremap = true})

keymap.set('n', '<Leader>t', '', {
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
