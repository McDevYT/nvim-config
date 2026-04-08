vim.cmd('cd /home/gabriel/projects/work/attribute-form/')
vim.cmd('edit designer/src/components/editor/Editor.tsx')
vim.fn.jobstart('pm2 delete attribute-form-designer || true && cd ~/projects/work/attribute-form/ && pm2 start npm --name "attribute-form-designer" -- run designer', { detach = true })
vim.cmd('wincmd p')
