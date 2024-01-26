return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
      })
    end,
  },

  {
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
  },

  {
    "askfiy/visual_studio_code",
    priority = 100,
    -- config = function()
    --   vim.cmd("colorscheme visual_studio_code")
    -- end,
  },
}
