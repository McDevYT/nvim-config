local opt = vim.opt

opt.list = true
opt.listchars = { eol = " " }
opt.relativenumber = false
opt.number = true
opt.cursorline = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

if vim.g.neovide then
  local g = vim.g
  opt.guifont = "JetBrainsMono NF"
  g.neovide_opacity = 1.9
  g.neovide_scale_factor = 0.75
  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_animate_command_line = true
  g.neovide_floating_blur_amount_x = 3
  g.neovide_floating_blur_amount_y = 3
  g.neovide_floating_shadow = true
  g.neovide_hide_mouse_when_typing = true
  g.neovide_cursor_trail_size = 0.4
  g.neovide_cursor_animation_length = 0.03
  g.neovide_cursor_vfx_mode = ""
end

vim.filetype.add({
  extension = {
    mcfunction = "mcfunction",
    tf = "terraform",
  },
})

opt.shortmess:append("c")
