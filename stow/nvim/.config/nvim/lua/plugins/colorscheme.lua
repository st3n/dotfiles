return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  -- config = function()
  --   -- load the colorscheme here
  --   vim.cmd([[colorscheme solarized-osaka]])
  -- end,
  opts = function()
    return {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
  end,
}
