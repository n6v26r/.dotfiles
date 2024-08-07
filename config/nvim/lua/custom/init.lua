local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
 autocmd("VimResized", {
   pattern = "*",
   command = "tabdo wincmd =",
 })

-- Disable line numbers when entering term buffer
autocmd('TermOpen', {
  command = 'setlocal nonumber norelativenumber',
})

-- Fix nvim-tree problems with sessions
autocmd('VimLeave', {
  pattern = "*",
  command = 'NvimTreeClose',
})

autocmd( {"VimLeave", "VimSuspend"}, {
  pattern = "*",
  command = "set guicursor=a:block-blinkon1"
})

autocmd( {"VimEnter", "VimResume"}, {
  pattern = "*",
  command = "set guicursor=n-c:block-blinkon1,v:block-blinkon0,i-ci-ve:ver25-blinkon1,r-cr:hor20,o:hor50"
})

local bind = vim.keymap.set

bind({'n', 'i'}, '<A-Down>', '<cmd>move .+1<CR>')
bind({'n', 'i'}, '<A-Up>', '<cmd>move .-2<CR>')
bind({'n', 'i'}, '<A-j>', '<cmd>move .+1<CR>')
bind({'n', 'i'}, '<A-k>', '<cmd>move .-2<CR>')

bind('v', '<A-Up>', ":move -2<CR>gv=gv", {silent = true})
bind('v', '<A-Down>', ":move '>+1<CR>gv=gv", {silent = true})
bind('v', '<A-k>', ":move -2<CR>gv=gv", {silent = true})
bind('v', '<A-j>', ":move '>+1<CR>gv=gv", {silent = true})

bind('v', '<leader>sr', ":SnipRun<CR>")
bind('v', '<leader>sr', ":SnipRun<CR>")
bind("n", "<space>rs", "<cmd>IronRepl<cr>")
bind("n", "<space>rr", "<cmd>IronRestart<cr>")
bind("n", "<space>rF", "<cmd>IronFocus<cr>")
bind("n", "<space>rh", "<cmd>IronHide<cr>")

bind('i', '<C-BS>', '<C-W>')
bind('i', '<C-h>', '<C-W>')
bind('i', '<A-BS>', '<C-W>')

bind({'n', 'i', 'v'}, "<C-=>", "<cmd>FontIncrease<CR>")
bind({'n', 'i', 'v'}, "<C-->", "<cmd>FontDecrease<CR>")

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.relativenumber = true

vim.o.showcmd = false
