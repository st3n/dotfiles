if vim.env.VSCODE then
  vim.g.vscode = true
end

-- vim.loader = false
if vim.loader then
  vim.loader.enable()
end

require("config.lazy")
