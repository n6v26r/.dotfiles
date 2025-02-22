-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

-- -@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
  NvDashAscii = { fg = "red", bg = "" },
}

---@type HLTable
M.add = {
  NvDashLazy = { fg = "red", bg = "" },
  NvimTreeOpenedFolderName = { fg = "green", bold = true },

  CompetiTestRunning = { bold = true },
  CompetiTestDone = { fg = "", bg = "" },
  CompetiTestCorrect = { fg = "green", bg = "" },
  CompetiTestWarning = { fg = "yellow", bg = "" },
  CompetiTestWrong = { fg = "red", bg = "" },
}

return M
