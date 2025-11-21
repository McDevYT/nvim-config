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
end
