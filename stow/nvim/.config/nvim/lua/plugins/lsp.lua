return {
  -- tools
  { "folke/neoconf.nvim", cmd = "Neoconf", config = true, dependencies = { "nvim-lspconfig" } },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
      },
    },
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
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      inlay_hints = { enabled = true },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      ---@type lspconfig.options
      servers = {
        ansiblels = {},
        bashls = {},
        clangd = {},
        dockerls = {},
        html = {},
        marksman = {},
        pyright = {
          enabled = true,
        },
        -- rust_analyzer = {
        -- settings = {
        --   ["rust-analyzer"] = {
        --     procMacro = { enable = true },
        --     cargo = { allFeatures = true },
        --     checkOnSave = {
        --       command = "clippy",
        --       extraArgs = { "--no-deps" },
        --     },
        --   },
        -- },
        -- },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hover = { expandAlias = false },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        vimls = {},
      },

      setup = {},
    },
  },

  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
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

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
        markdown = { "markdownlint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
