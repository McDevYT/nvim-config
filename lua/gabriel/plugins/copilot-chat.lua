return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary", -- "canary" (development) is currently recommended for the latest features
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or "github/copilot.vim"
    { "nvim-lua/plenary.nvim" },   -- required for math/utility functions
  },
  build = function()
    if vim.fn.executable("make") == 1 then
      vim.fn.system({ "make", "tiktoken" })
    end
  end,
  opts = {
    -- specific options for the chat window
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float', or 'replace'
      width = 0.5,         -- fractional width of parent, or absolute width in columns
      height = 0.5,        -- fractional height of parent, or absolute height in rows
      -- Options below only apply to floating windows
      relative = 'editor',
      border = 'single',
      row = nil,
      col = nil,
      title = 'Copilot Chat',
      footer = nil,
      zindex = 1,
    },
    show_help = true, -- Shows help message as virtual text when asking the chat
  },
  keys = {
    -- Quick chat toggle
    {
      "<leader>cc",
      ":CopilotChatToggle<CR>",
      desc = "Toggle Copilot Chat",
      mode = { "n", "v" },
    },
    -- Quick chat reset
    {
      "<leader>cr",
      ":CopilotChatReset<CR>",
      desc = "Reset Copilot Chat",
      mode = { "n", "v" },
    },
    -- Ask Copilot regarding selected code
    {
      "<leader>cq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
        end
      end,
      desc = "Copilot Chat - Quick Chat",
      mode = { "n", "v" },
    },
  },
}
