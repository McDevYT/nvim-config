return {
    {
        "klen/nvim-test",
        cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-test").setup({
                runners = {
                    javascript = "jest",
                    typescript = "jest",
                    javascriptreact = "jest",
                    typescriptreact = "jest",
                },
                run = {
                    terminal = "integrated",
                },
            })
        end,
    },
}
