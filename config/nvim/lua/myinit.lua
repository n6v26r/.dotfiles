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

-- Reload ibl on theme change
autocmd("User", {
  pattern = "NvThemeReload",
  callback = function ()
    dofile(vim.g.base46_cache .. "blankline")
  end
})

local plugins = {
  "python3_provider",
  "plugin/rplugin.vim"
}

for _, plugin in pairs(plugins) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

