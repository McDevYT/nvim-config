local opt = vim.opt
local g = vim.g

opt.list = true
opt.listchars = { eol = " " }
opt.relativenumber = true
opt.number = true
opt.cursorline = true

opt.swapfile = false
opt.backup = false
opt.undofile = true
local undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undodir = undodir

if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.ignorecase = true
opt.smartcase = true
opt.shortmess:append("c")

if g.neovide then
  opt.guifont = "JetBrainsMono NF"
  g.neovide_opacity = 1
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
    tsx = "typescriptreact",
  },
})
