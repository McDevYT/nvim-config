vim.cmd('cd /home/gabriel/projects/work/attribute-form/designer/')
vim.cmd('edit src/components/schema/Schemas.tsx')
vim.cmd('tabnew')
vim.cmd('term npm start')
vim.cmd('tabprevious')

require'nvim-tree.api'.tree.open()
vim.cmd('wincmd p')
