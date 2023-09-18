local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
 autocmd("VimResized", {
   pattern = "*",
   command = "tabdo wincmd =",
 })

local bind = vim.keymap.set

bind({'n', 'i'}, '<A-Down>', '<cmd>move .+1<CR>')
bind({'n', 'i'}, '<A-Up>', '<cmd>move .-2<CR>')
bind('i', '<C-BS>', '<C-W>')
bind('i', '<A-BS>', '<C-W>')

vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.relativenumber = true
