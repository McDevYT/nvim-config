
return{
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- for file icons
        },
        cmd = "NvimTreeToggle",
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 35,
                    side = "right",
                    preserve_window_proportions = true,
                },
                renderer = {
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                        },
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
            })
        end,
    },
}
