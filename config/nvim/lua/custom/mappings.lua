---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ['<leader>sd'] = {"<cmd>Autosession delete<CR>", "Session delete"},
    ['<leader>fc'] = {"<cmd>Telescope builtin<CR>", "Find command"},
    ['<leader>cf'] = {"<cmd>next ~/.config/nvim/lua/custom/*.lua<CR>", "Config"},
  },
  t = {
    ["<Esc>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },
}

M.telescope = {
  n = {
    ["<leader>fs"] = { "<cmd> Telescope session-lens search_session<CR>", "Find session" },
  }
}
-- more keybinds!

return M
