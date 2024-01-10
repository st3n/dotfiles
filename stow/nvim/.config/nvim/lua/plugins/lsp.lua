return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clangd",
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
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- lsp servers
  -- {
  --   -- ln -s /path/to/myproject/build/compile_commands.json /path/to/myproject/
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = true },
  --     ---@type lspconfig.options
  --     servers = {
  --       clangd = {},
  --       pyright = {},
  --       cmake = {},
  --     },
  --     setup = {},
  --   },
  -- },
}
