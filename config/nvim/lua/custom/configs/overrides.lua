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
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
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

M.ui = {
  statusline = {
    theme = "vscode",
    -- separator_style = "",
  },

  tabufline = {
    lazyload = false;
  },
}

local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
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
      { name = "nvim_lsp", keyword_length = 3 },
      { name = "luasnip", keyword_length = 3 },
      { name = "buffer", keyword_length = 3  },
      { name = "nvim_lua", keyword_length = 3  },
      { name = "path", keyword_length = 3  },
  },
  }
end

return M
