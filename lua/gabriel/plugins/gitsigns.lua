return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add          = { text = "+" },
            change       = { text = "~" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
        },
        current_line_blame = false,
        current_line_blame_opts = {
            delay = 500,
            virt_text_pos = "eol",
        },
    },
    -- We add this config function to apply the global fix
    config = function(_, opts)
        require("gitsigns").setup(opts)
        vim.opt.signcolumn = "yes" 
    end,
}
