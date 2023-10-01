local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
 autocmd("VimResized", {
   pattern = "*",
   command = "tabdo wincmd =",
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

bind('i', '<C-BS>', '<C-W>')
bind('i', '<A-BS>', '<C-W>')

vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.relativenumber = true

vim.opt.guifont = { "FiraCode Nerd Font Mono,JetBrains NFM,Hack Nerd Font Mono", "h14" }
