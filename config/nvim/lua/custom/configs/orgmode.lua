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
