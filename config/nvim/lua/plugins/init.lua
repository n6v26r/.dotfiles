local overrides = require("configs.overrides")

return {
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'etovxqpdygfblzhckisuran'
    },
    init = function ()
      local set = vim.api.nvim_set_hl
      set(0, 'HopCursor', { link = 'Cursor', default = true })
      set(0, 'HopPreview', { link = 'DiagnosticWarn', default = true })
      set(0, 'HopUnmatched', { link = 'Comment', default = true })
      set(0, 'HopNextKey2', { link = "DiagnosticHint", default = true })
      set(0, 'HopNextKey1', { link = "DiagnosticError", default = true })
      set(0, 'HopNextKey', { link = "DiagnosticError", default = true })
    end,
    lazy = false
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

  { -- orgmode for neovim
    'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup_ts_grammar()
      require('orgmode').setup({
        org_agenda_files = {'~/Documents/org/*'},
        mappings = {
          org = {
            org_cycle = "<leader>of",
            org_global_cycle = "<leader>ogf"
          }
        }
      })
    end,
    ft = {'org'},
  },

  {
    "akinsho/org-bullets.nvim",
    config = function ()
      require("org-bullets").setup({
        concealcursor = true,
      });
    end,
    ft = {"org"}
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = {"org", "markdown", "txt"}
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.autocommands"] = {},
          ["core.integrations.treesitter"] = {},
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                default = "~/Documents",
                algo = "~/stuff/algo"
              },
            },
          },
        },
      }
    end,
    ft = {"norg"},
  },

  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    init = function ()
      local set = vim.api.nvim_set_hl
      set(0, 'SniprunVirtualTextOk', { default = true, link = "DiagnosticHint"})
      set(0, 'SniprunFloatingWinOk', { default = true, link = "DiagnosticHint"})
      set(0, 'SniprunVirtualTextErr', { default = true, link = "DiagnosticError"})
      set(0, 'SniprunFloatingWinErr', { default = true, link = "DiagnosticError"})
    end,
    ft = {"org", "norg", "markdown", "c", "cpp", "python", "sh"}
  },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            -- vim.g.molten_virt_text_output = true
            vim.g.molten_auto_open_output = true 
            vim.g.molten_cover_empty_lines = true
        end,
      ft = {"python"}
    },
  {
      -- see the image.nvim readme for more information about configuring this plugin
      "3rd/image.nvim",
      opts = {
          backend = "kitty", -- whatever backend you would like to use
          max_width = 100,
          max_height = 12,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      },
  },
  {
    "hkupty/iron.nvim",
    config = function(plugins, opts)
      local iron = require("iron.core")

      iron.setup({
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
            cpp = {
              command = { "cling" }
            },
            c = {
              command = { "cling", "-x", "c"}
            }
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
      })
    end,
    ft = {"python"}
  },

  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function()
      local otter = require("otter")
      otter.setup{
        lsp = {
          diagnostic_update_events = {"InsertLeave"}
        },
        buffers = {
          set_filetype = true
        }
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = {"*.md", "*.mdx", "*.org", "*.norg", "*.ipynb"},
        callback = function() require('otter').activate() end,
      })
    end,
  },

  {
    'AckslD/nvim-FeMaco.lua',
    config = function ()
      require("femaco").setup()
    end,
    ft = {"org", "neorg", "markdown"}
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
    lazy = false;
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
        font = "FiraCode Nerd Font,JetBrainsMono NF,Hack Nerd Font",
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
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {  use_diagnostic_signs = true, height = 6, },
    keys = {
      { "<leader>tx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>tX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>tL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>tQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  { -- discord game recongnition
    'andweeb/presence.nvim',
    lazy = false
  },

}
