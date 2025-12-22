return {
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

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          if root and root ~= "" then
            vim.cmd("cd " .. root)
          end
        end,
      })
    end,
  },
}
