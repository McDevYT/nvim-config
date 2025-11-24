local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.cursorline = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

if vim.g.neovide then
	opt.guifont = 'JetBrainsMono NF'
    vim.g.neovide_opacity = 0.8
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_floating_blur_amount_x = 3
    vim.g.neovide_floating_blur_amount_y = 3
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_hide_mouse_when_typing = true
end

