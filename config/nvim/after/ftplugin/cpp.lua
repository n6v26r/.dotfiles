vim.cmd("setlocal shiftwidth=2")
vim.cmd("setlocal tabstop=2")
vim.cmd("setlocal softtabstop=2")

local bind = vim.keymap.set

--compile current file
bind('n', '<A-1>', '<cmd>! g++ -Wall -Wextra %:t -o %:t:r<CR>', { buffer = true } )
--execute current file
bind('n', '<A-2>', '<cmd>! ./%:t:r<CR>', { buffer = true } )
