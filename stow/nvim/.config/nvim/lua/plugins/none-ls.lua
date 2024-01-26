return {
  {
    "jay-babu/mason-null-ls.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    opts = {
      automatic_setup = true,
      ensure_installed = { "black", "cpplint", "prettier" },
      automatic_installation = true,
    },
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "VeryLazy" },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.capabilities = {
        offsetEncoding = { "utf-16" },
      }
      opts.debug = true
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.cppcheck,
        -- null_ls.builtins.diagnostics.clang_check,
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.completion.tags,
      })
    end,

    --[[
    on_attach = function(client, bufnr)
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
          group = augroup,
          buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  --]]
  },
}
