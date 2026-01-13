local theme_dir = vim.fn.stdpath("config") .. "/lua/gabriel/plugins/colorschemes/weird"

local function list_themes()
  local out = {}
  local handle, err = vim.loop.fs_scandir(theme_dir)
  if not handle then
    print("Failed to scan folder:", theme_dir, err)
    return out
  end

  while true do
    local name, t = vim.loop.fs_scandir_next(handle)
    if not name then break end
    if t == "file" and name:match("%.lua$") then
      table.insert(out, (name:gsub("%.lua$", "")))  -- wrap in () to take only first return value
    end
  end

  return out
end

local function RandomWeirdTheme()
  local themes = list_themes()
  if #themes == 0 then
    print("No themes found in:", theme_dir)
    return
  end

  math.randomseed(os.time())
  local choice = themes[math.random(#themes)]

  local ok, mod = pcall(require, "gabriel.plugins.colorschemes.weird." .. choice)
  if ok then
    if type(mod.setup) == "function" then
      mod.setup()
    else
      vim.cmd("colorscheme " .. choice)
    end
    print("Loaded theme:", choice)
  else
    print("Failed to load theme:", choice, "\nError:", mod)
  end
end

vim.api.nvim_create_user_command("RandomWeirdTheme", RandomWeirdTheme, {})
