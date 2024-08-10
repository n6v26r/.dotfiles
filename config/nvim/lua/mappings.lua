require "nvchad.mappings"

local bind = vim.keymap.set
bind({'n'}, ';', ':', { desc = "CMD enter command mode" })
bind({'n'}, '<leader>sd', "<cmd>Autosession delete<CR>", { desc = "Delete saved session" })
bind({'n', 'v'}, '<leader>sr', "<cmd>SnipRun<CR>", {desc = "Run snippet line"})
bind({'n'}, '<leader>sc', "<cmd>SnipClose<CR>", {desc = "Clear snippet output"})
bind({'n'}, '<leader>se', '<cmd>FeMaco<CR>', {desc = "Edit snippet" })
bind({'n'}, '<leader>fc', '<cmd>Telescope builtin<CR>', {desc = "Find command" })
bind({'n'}, '<leader>cf', '<cmd>next ~/.config/nvim/lua/*.lua<CR>', {desc = "Edit Config" })
bind({'n'}, '<leader>fs', "<cmd>SessionSearch<CR>", {desc = "Find session"})

bind('n', '<leader>mi', '<cmd>MoltenInit<CR>', {desc = "Init Molten"})
bind("n", "<leader>mec", ":MoltenReevaluateCell<CR>", { desc = "Molten re-eval cell", silent = true })
bind('n', '<leader>mel', '<cmd>MoltenEvaluateLine<CR>', {desc = "Molten eval line"})
bind("v", "<leader>mev", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten eval visual", silent = true })
bind("n", "<leader>moe", ":noautocmd MoltenEnterOutput<CR>", { desc = "Molten enter output", silent = true })
bind("n", "<leader>meo", ":MoltenEvaluateOperator<CR>", { desc = "Molten eval operator", silent = true })

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

bind("n", "<space>T", "<cmd>lua require('otter').activate()<CR>", {desc = "Activate otter"})

bind('i', '<C-BS>', '<C-W>')
bind('i', '<C-h>', '<C-W>')
bind('i', '<A-BS>', '<C-W>')

bind({'n', 'i', 'v'}, "<C-=>", "<cmd>FontIncrease<CR>")
bind({'n', 'i', 'v'}, "<C-->", "<cmd>FontDecrease<CR>")

