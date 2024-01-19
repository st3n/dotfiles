return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clangd",
        "pyright",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       pyright = {},
  --       clangd = {},
  --     },
  --     setup = {},
  --   },
  -- },

  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    require("lspconfig").clangd.setup({
      on_new_config = function(new_config, _)
        local status, cmake = pcall(require, "cmake-tools")
        if status then
          cmake.clangd_on_new_config(new_config)
        end
      end,
    }),
    keys = {
      { "<leader>cg", "<cmd>CmakeGenerate<cr>", desc = "cmake generate" },
      { "<leader>cb", "<cmd>CmakeBuild<cr>", desc = "cmake build" },
      { "<leader>cc", "<cmd>CmakeClean<cr>", desc = "cmake clean" },
      { "<leader>cq", "<cmd>CmakeClose<cr>", desc = "cmake close" },
    },
  },
}
