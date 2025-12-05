
return {
    "prettier/vim-prettier",
    build = "yarn install --frozen-lockfile --production", -- optional if using yarn, or npm i
    ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "css", "scss", "json", "html", "markdown" }, -- filetypes to enable
    init = function()
        -- Use Prettier CLI from node_modules if available
        vim.g['prettier#exec_cmd_path'] = "prettier"

        -- Enable format on save
        vim.cmd([[
            autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.css,*.scss,*.json,*.html,*.md PrettierAsync
        ]])

        -- Optional: map manual formatting
        vim.api.nvim_set_keymap('n', '<leader>p', ':Prettier<CR>', { noremap = true, silent = true })
    end,
}
