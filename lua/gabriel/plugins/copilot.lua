return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      -- PASTE THE PATH FROM STEP A HERE:
      copilot_node_command = '/usr/sbin/node', 
      
      suggestion = { enabled = true },
      panel = { enabled = false },
    })
  end,
}
