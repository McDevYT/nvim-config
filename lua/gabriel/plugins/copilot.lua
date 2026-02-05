return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    local node = vim.fn.exepath("node")
    require("copilot").setup({
      copilot_node_command = node ~= "" and node or nil,
      
      suggestion = { enabled = true },
      panel = { enabled = false },
    })
  end,
}
