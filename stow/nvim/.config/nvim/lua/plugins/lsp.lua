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
      autoformat = false,
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
            "--compile-commands-dir=build",
            "--query-driver=/home/igor/repo/sheila/build/tmp/work/aarch64-poky-linux/onvif-adapter/1.0.0-r0/recipe-sysroot-native/usr/bin/aarch64-poky-linux/aarch64-poky-linux-g*",

            -- /home/igor/repo/sheila/build/tmp/work/aarch64-poky-linux/onvif-adapter/1.0.0-r0/recipe-sysroot/usr/include/c++/9.2.0                                                                                                      --         /-2,0s
            "--enable-config",
            "--function-arg-placeholders",
            "--completion-style=detailed",
            "--fallback-style=Google",
            "--header-insertion=iwyu",
            "--j=4",
            "--malloc-trim",
            "--pch-storage=memory",
            "--log=verbose",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        },
      },

      setup = {
        clangd = function(server, opts)
          clangd_on_new_config = function(new_config, _)
            local status, cmake = pcall(require, "cmake-tools")
            if status then
              cmake.clangd_on_new_config(new_config)
            end
          end
          return false
        end,

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
      build_directory = "~/repo/sheila/build/tmp/work/aarch64-poky-linux/onvif-adapter/1.0.0-r0/build",
      require("cmake-tools").setup({
        cmake_soft_link_compile_commands = false, -- this will automatically make a soft link from compile commands file to project root dir
        cmake_compile_commands_from_lsp = true, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
        cmake_kits_path = "~/repo/sheila/cmake-kits.json",
      }),
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
