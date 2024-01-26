return {
  {
    "folke/neodev.nvim",
    opts = {
      experimental = {
        pathStrict = true,
      },

      library = {
        runtime = "~/projects/neovim/runtime/",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
    lazy = false,
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "j-hui/fidget.nvim",
    },
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
        "lua_ls",
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
      },

      auto_install = true,
    },

    config = function()
      require("fidget").setup({})
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- the rest defined in lazyvim lsp
      "hrsh7th/cmp-nvim-lsp",
      "Civitasv/cmake-tools.nvim",
    },

    opts = {
      diagnostics = {
        virtual_text = { prefix = "icons" },
        update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },

      inlay_hints = { enabled = true },

      capabilities = {
        offsetEncoding = { "utf-16" },
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },

      ---@type lspconfig.options
      servers = {
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

                globals = { "vim" },
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

        clangd = {
          single_file_support = true,
          mason = false,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--compile-commands-dir=/code/.clang-build",
            "--function-arg-placeholders",
            "--completion-style=detailed",
            "--fallback-style=Google",
            "--header-insertion=iwyu",
            "--j=4",
            "--malloc-trim",
            "--pch-storage=memory",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        },
      },

      setup = {
        --   clangd = function(server, opts)
        --     clangd_on_new_config = function(new_config, _)
        --       local status, cmake = pcall(require, "cmake-tools")
        --       if status then
        --         cmake.clangd_on_new_config(new_config)
        --       end
        --     end
        --     return false
        --   end,

        ["*"] = function(server, opts)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("lspconfig")[server].setup({
            capabilities = capabilities,
            server = opts,
          })
          return false
        end,
      },
    },
  },

  {
    "p00f/clangd_extensions.nvim",
    opts = {
      inlay_hints = {
        inline = true,
      },
    },
  },

  {
    "Civitasv/cmake-tools.nvim",

    opts = {
      keys = {
        { "<leader>cg", "<cmd>CmakeGenerate<cr>", desc = "cmake generate" },
        { "<leader>cb", "<cmd>CmakeBuild<cr>", desc = "cmake build" },
        { "<leader>cc", "<cmd>CmakeClean<cr>", desc = "cmake clean" },
        { "<leader>cq", "<cmd>CmakeClose<cr>", desc = "cmake close" },
      },
      build_directory = "../build",
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
