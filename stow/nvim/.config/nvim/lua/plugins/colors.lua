return {
  {
    "catppuccin/nvim",
    name = "catppuccin", -- This is the name Lazy uses for the plugin
    lazy = false,
    priority = 1000, -- Load early to set colorscheme before other plugins
    opts = {
      flavour = "frappe",
      auto_integrations = true,
    },
  },

  {
    "akinsho/bufferline.nvim",
    after = "catppuccin",
    config = function()
      require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
      })
    end,
  },
}
