require "nvchad.mappings"

local bind = vim.keymap.set
bind({'n'}, '<leader>lf', function ()
  vim.diagnostic.open_float { border = "rounded" }
end, {desc = "Floating diagnostic"})

bind({'n'}, ';', ':', { desc = "CMD enter command mode" })
bind({'n', 'v'}, '<leader>sr', "<cmd>SnipRun<CR>", {desc = "Run snippet line"})
bind({'n'}, '<leader>sc', "<cmd>SnipClose<CR>", {desc = "Clear snippet output"})
bind({'n'}, '<leader>se', '<cmd>FeMaco<CR>', {desc = "Edit snippet" })
bind({'n'}, '<leader>fc', '<cmd>Telescope builtin<CR>', {desc = "Find command" })
bind({'n'}, '<leader>cf', '<cmd>next ~/.config/nvim/lua/*.lua<CR>', {desc = "Edit Config" })

bind("n", "<leader>jw", function()
  require'hop'.hint_words()
end, {desc = "Jump to word"})

bind("n", "<leader>jl", function()
  require'hop'.hint_lines()
end, {desc = "Jump to line"})

bind("n", "<leader>ja", function()
  require'hop'.hint_anywhere()
end, {desc = "Jump anywhere"})

bind("n", "<leader>jcC", function()
    require'hop'.hint_camel_case()
end, {desc = "Jump camel case"})

bind({'n', 'i'}, '<A-Down>', '<cmd>move .+1<CR>')
bind({'n', 'i'}, '<A-Up>', '<cmd>move .-2<CR>')
bind({'n', 'i'}, '<A-j>', '<cmd>move .+1<CR>')
bind({'n', 'i'}, '<A-k>', '<cmd>move .-2<CR>')

bind('v', '<A-Up>', ":move -2<CR>gv=gv", {silent = true})
bind('v', '<A-Down>', ":move '>+1<CR>gv=gv", {silent = true})
bind('v', '<A-k>', ":move -2<CR>gv=gv", {silent = true})
bind('v', '<A-j>', ":move '>+1<CR>gv=gv", {silent = true})

bind("n", "<space>rs", "<cmd>IronRepl<cr>")
bind("n", "<space>rr", "<cmd>IronRestart<cr>")
bind("n", "<space>rF", "<cmd>IronFocus<cr>")
bind("n", "<space>rh", "<cmd>IronHide<cr>")

bind('i', '<C-BS>', '<C-W>')
bind('i', '<A-BS>', '<C-W>')

bind({'n', 'i', 'v'}, "<C-=>", "<cmd>FontIncrease<CR>")
bind({'n', 'i', 'v'}, "<C-->", "<cmd>FontDecrease<CR>")

-- Keyboard users
bind("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
bind({"n", "i"}, "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

