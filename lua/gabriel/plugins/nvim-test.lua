return {
    {
        "klen/nvim-test",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- Setup nvim-test
            require("nvim-test").setup({
                runners = {
                    javascript = "jest",
                    typescript = "jest",
                    javascriptreact = "jest",
                    typescriptreact = "jest",
                },
                -- Optional: run tests in terminal
                run = {
                    terminal = "integrated", -- or "neoterm", or "toggleterm" (requires extra plugin)
                },
            })
        end,
    },
}
