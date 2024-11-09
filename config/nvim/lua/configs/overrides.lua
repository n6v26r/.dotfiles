local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "c_sharp",
    "markdown",
    "markdown_inline",
    "json",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = true,
    disable = { "latex" }
  }
}

M.mason = {
  cmd = true,
  pkgs = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    --csharp stuff
    "csharp-language-server",

    --markdown-stuff
    "marksman",

    --python
    "pyright",

    -- latex
    "textlsp",
    "ltex-ls",
    "texlab",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' },
    }, {
      { name = 'zsh' }
    }
    ),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    }
  })
  M.cmp = {
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
    	["<Down>"] = cmp.mapping.select_next_item(),
    	["<C-j>"] = cmp.mapping.select_next_item(),
      ["<Esc>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm {behavior = cmp.ConfirmBehavior.Insert, select = true,}
          elseif require("luasnip").expand_or_locally_jumpable() then
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
            cmp.confirm()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
    },
    sources = {
      { name = "nvim_lsp",  keyword_length = 3 },
      { name = "otter",     keyword_length = 3 },
      { name = "luasnip",   keyword_length = 3 },
      { name = "nvim_lua",  keyword_length = 3 },
      { name = "path",      keyword_length = 3 },
      -- { name = "buffer", keyword_length = 3},
    },
  }
end

return M
