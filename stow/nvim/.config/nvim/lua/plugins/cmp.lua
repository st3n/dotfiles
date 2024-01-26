return {

  { "hrsh7th/cmp-nvim-lsp" },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",

    keys = function()
      return {}
    end,
  },

  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim", -- vs-code like pictograms

      -- codeium
      {
        "Exafunction/codeium.nvim",
        cmd = "Codeium",
        build = ":Codeium Auth",
        opts = {},
      },
    },

    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local cmp_select = { behaviour = cmp.SelectBehavior.Select }
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.filetype_extend("c", { "cdoc" })
      luasnip.filetype_extend("cpp", { "cppdoc" })
      luasnip.filetype_extend("python", { "pydoc" })
      luasnip.filetype_extend("sh", { "shelldoc" })

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },

        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.close(),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "path" }, -- file system paths
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
