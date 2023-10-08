local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {"williamboman/mason-lspconfig.nvim",},

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  { -- guess file indetation
    "nmac427/guess-indent.nvim",
    config = function ()
      require('guess-indent').setup {}
    end,
    lazy = false
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
      "ibhagwan/fzf-lua" -- optional
    },

    config = function(_, opts)
      require("neogit").setup(opts)
    end,
    opts = {},
  },

  { -- Integrated Tests -- CONFIG
    "nvim-neotest/neotest",

    keys = {
      {
        "<leader>to",
        ":Neotest summary<CR>",
        mode = "n",
        desc = "Open interactive test session",
      },
      {
        "<leader>te",
        ":Neotest run<CR>",
        mode = "n",
        desc = "Run tests for the session",
      },
    },

    dependencies = {
      -- Required
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",

      -- Dev
      "rouge8/neotest-rust", -- Rust development
    },

    config = function(_, opts)
      require("neotest").setup {
        adapters = {
          require "neotest-rust",
          -- require "neotest-vim-test" {
          --   ignore_file_types = { "python", "vim", "lua" },
          -- },
        },
      }
    end,
  },

  { -- Minimap
    "gorbit99/codewindow.nvim",

    keys = {
      {
        "<leader>mm",
        "codewindow.toggle_focus()",
        mode = "n",
        desc = "Focus Minimap",
      },
    },

    config = function(_, opts)
      local codewindow = require "codewindow"
      codewindow.setup(opts)
      codewindow.apply_default_keybinds()
    end,

    opts = {
      use_lsp = true,
      use_treesitter = true,
      show_cursor = false,
      use_git = true,
      width_multiplier = 5,
      screen_bounds = "lines",
      window_border = "none",
    },
  },

  { -- Translate
    "voldikss/vim-translator",

    keys = {
      { "<leader>tt", ":TranslateW<CR>", mode = "v", desc = "Translate selected test" },
      { "<leader>tc", ":TranslateX<CR>", mode = "v", desc = "Translate & Copy selected text" },
      { "<leader>tr", ":TranslateR<CR>", mode = "v", desc = "Replace text with Translation" },
    },

    config = function()
      vim.g.translator_target_lang = "en"
      vim.g.translator_window_type = "popup"
    end,
  },

  { -- orgmode for neovim
    'nvim-orgmode/orgmode',
    ft = {'org'},
    config = function()
      require("custom.configs.orgmode")
    end,
    lazy = false
  },

  { -- auto create sessions
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = vim.log.levels.ERROR,
        auto_session_suppress_dirs = {"~"},
        session_lens = {
          path_display = {'shorten'},
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = false },
          previewer = false,
        },
      }
    end,
    lazy = false
  },

  { -- smooth scrolling
    "karb94/neoscroll.nvim",
    config = function ()
      require('neoscroll').setup()
    end,
    lazy = false
  },

  { -- control gui fontsize
    "Sup3Legacy/fontsize.nvim",
    config = function ()
      require("fontsize").init({
        font = "FiraCode Nerd Font Mono,JetBrains NFM,Hack Nerd Font Mono",
        min = 6,
        default = 12,
        max = 22,
        step = 1,
      })
    end,
    lazy = false;
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
    -- For Kitty Terminal Emulator
    -- build = "./kitty/install-kittens.bash",
    keys = {
      {
        "<C-A-Up>",
        function()
          require("smart-splits").resize_up(5)
        end,
        mode = "n",
        desc = "Resize Up",
      },
      {
        "<C-A-Down>",
        function()
          require("smart-splits").resize_down(5)
        end,
        mode = "n",
        desc = "Resize Down",
      },
      {
        "<C-A-Left>",
        function()
          require("smart-splits").resize_left(5)
        end,
        mode = "n",
        desc = "Resize Left",
      },
      {
        "<C-A-Right>",
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

  {
    "braxtons12/blame_line.nvim",
    config = function()
 		  require("blame_line").setup {
 		    -- whether the blame line should be shown in visual modes
 			  show_in_visual = false,

 			  -- whether the blame line should be shown in insert mode
 			  show_in_insert = false,

        delay = 0,
      }
 	  end,
    keys = {
      {
        "<leader>tb",
        function()
          vim.cmd("silent BlameLineToggle")
        end,
        mode = "n",
        desc = "Toggle blame",
      }
    },
    lazy = false
  },

  { -- discord game recongnition
    'andweeb/presence.nvim',
    config = function()
      require('custom.configs.presence')
    end,
    lazy = false
  },
}

return plugins
