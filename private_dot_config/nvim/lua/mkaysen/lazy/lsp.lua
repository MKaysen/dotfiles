return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("neodev").setup({})

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "tsserver",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
      },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
          })(entry, vim_item)
          local kind_strings = vim.split(kind.kind, "%s", { trimempty = true })

          kind.kind = " " .. (kind_strings[1] or "") .. " "
          kind.menu = "    (" .. (kind_strings[2] or "") .. ")"

          return kind
        end,
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })
  end,
}
