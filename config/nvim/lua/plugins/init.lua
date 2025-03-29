local overrides = require "configs.overrides"

-- TODO: organize this mess!

return {
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup()
    end,
    ft = {"c", "cpp"}
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  { "nvzone/timerly", cmd = "TimerlyToggle" },

  {
    "RaafatTurki/hex.nvim",
    config = function(_, opts)
      require("hex").setup()
    end,
    cmd = "HexDump",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        after = "",
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup(opts)
    end,
    event = "User FilePost",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function(_, conf)
      conf.extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_ivy {
            layout_config = {
              height = 0.3,
            },
          },
        },
      }
      return conf
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension "ui-select"
    end,
    lazy = false,
  },

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-file-line-error",
          "-synctex=1",
          "-shell-escape",
        },
      }
    end,
  },

  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      save_path = "~/Pictures",
      has_breadcrumbs = false,
      bg_theme = "bamboo",
    },
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "hop")
      require("hop").setup(opts)
    end,
    lazy = true,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "configs.null-ls"
        end,
      },
    },
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "tamago324/cmp-zsh",
    },
    opts = overrides.cmp,
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  { "williamboman/mason-lspconfig.nvim" },

  { -- guess file indetation
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup {}
    end,
    event = "User FilePost",
  },

  {
    "NeogitOrg/neogit",

    keys = {
      {
        "<leader>gg",
        "<cmd> Neogit<CR>",
        mode = "n",
        desc = "Open Neogit",
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      dofile(vim.g.base46_cache .. "neogit")
      require("neogit").setup(opts)
    end,
    opts = {},
  },

  { -- Translate
    "voldikss/vim-translator",

    keys = {
      { "<leader>tw", ":TranslateW<CR>", mode = "v", desc = "Translate selected test" },
      { "<leader>tc", ":TranslateX<CR>", mode = "v", desc = "Translate & Copy selected text" },
      { "<leader>tr", ":TranslateR<CR>", mode = "v", desc = "Replace text with Translation" },
    },

    config = function()
      vim.g.translator_target_lang = "en"
      vim.g.translator_window_type = "popup"
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    -- lazy = false, -- Recommended
    ft = "markdown", -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      latex = {
        enable = true,
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "markview")
      require("markview").setup(opts)
    end,
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = { "org", "markdown", "txt" },
  },

  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    init = function()
      local set = vim.api.nvim_set_hl
      set(0, "SniprunVirtualTextOk", { default = true, link = "Comment" })
      set(0, "SniprunFloatingWinOk", { default = true, link = "Comment" })
      set(0, "SniprunVirtualTextErr", { default = true, link = "cCommentError" })
      set(0, "SniprunFloatingWinErr", { default = true, link = "cCommentError" })
    end,
    ft = { "org", "norg", "markdown", "c", "cpp", "python", "sh" },
  },

  {
    "hkupty/iron.nvim",
    config = function(plugins, opts)
      local iron = require "iron.core"

      iron.setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            python = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "ipython", "--no-banner", "--no-autoindent" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = "vertical botright 60 split",
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>rc",
          visual_send = "<space>rc",
          send_file = "<space>rf",
          send_line = "<space>rl",
          send_mark = "<space>rm",
          mark_motion = "<space>rmc",
          mark_visual = "<space>rmc",
          remove_mark = "<space>rmd",
          cr = "<space>r<cr>",
          interrupt = "<space>r<space>",
          exit = "<space>rq",
          clear = "<space>rx",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }
    end,
    ft = { "python" },
  },

  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function()
      local otter = require "otter"
      otter.setup {
        lsp = {
          diagnostic_update_events = { "InsertLeave" },
        },
        buffers = {
          set_filetype = true,
        },
      }
    end,
    keys = {
      {
        "<leader>lsp",
        function()
          require("otter").activate()
        end,
        mode = "n",
        desc = "Otter reload",
      },
      ft = { "markdown", "org", "norg" },
    },
  },

  {
    "AckslD/nvim-FeMaco.lua",
    config = function()
      require("femaco").setup()
    end,
    ft = { "org", "neorg", "markdown" },
  },

  { -- auto create sessions
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = vim.log.levels.ERROR,
        auto_session_suppress_dirs = { "~" },
        session_lens = {
          load_on_setup = false,
          path_display = { "shorten" },
          buftypes_to_ignore = {},
          theme_conf = { border = false },
          previewer = false,
        },
      }
    end,
    keys = {
      {
        "<leader>fs",
        "<cmd>SessionSearch<CR>",
        mode = "n",
        desc = "Find session",
      },
      {
        "<leader>sd",
        "<cmd>Autosession delete<CR>",
        mode = "n",
        desc = "Delete session",
      },
    },
    lazy = false,
  },

  { -- smooth scrolling
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
    lazy = false,
  },

  { -- control gui fontsize
    "Sup3Legacy/fontsize.nvim",
    config = function()
      require("fontsize").init {
        font = "FiraCode Nerd Font,JetBrainsMono NF,Hack Nerd Font",
        min = 6,
        default = 12,
        max = 40,
        step = 1,
      }
    end,
    lazy = false,
  },

  { -- Glyph Picker
    "2kabhishek/nerdy.nvim",

    keys = {
      {
        "<leader>fe",
        "<cmd>Nerdy<CR>",
        mode = "n",
        desc = "Glyph Picker",
      }, -- Gigantic Search Base
    },

    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },

  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<C-A-k>",
        function()
          require("smart-splits").resize_up(5)
        end,
        mode = "n",
        desc = "Resize Up",
      },
      {
        "<C-A-j>",
        function()
          require("smart-splits").resize_down(5)
        end,
        mode = "n",
        desc = "Resize Down",
      },
      {
        "<C-A-h>",
        function()
          require("smart-splits").resize_left(5)
        end,
        mode = "n",
        desc = "Resize Left",
      },
      {
        "<C-A-l>",
        function()
          require("smart-splits").resize_right(5)
        end,
        mode = "n",
        desc = "Resize Right",
      },

      {
        "<leader>mr",
        function()
          require("smart-splits").start_resize_mode()
        end,
        mode = "n",
        desc = "Resize Mode",
      },
    },

    config = function(_, opts)
      require("smart-splits").setup()
    end,
  },
}
