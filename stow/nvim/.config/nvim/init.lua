if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("util.debug").dump(...)
end
vim.print = _G.dd

if vim.g.vscode then
  -- VSCode extension
else
  -- ordinary Neovim
end

require("config.lazy")
