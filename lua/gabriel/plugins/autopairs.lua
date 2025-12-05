
return {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,        -- integrates with Treesitter for better pairing
            fast_wrap = {},         -- optional: for quickly wrapping words or selections
        })
    end
}
