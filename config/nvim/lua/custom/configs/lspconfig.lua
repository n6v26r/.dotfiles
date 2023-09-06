local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local pid = vim.fn.getpid()

lspconfig.marksman.setup({
  cmd = { "marksman", "server" };
  filetypes = { "markdown" };
  single_file_support = true;
})

lspconfig.omnisharp.setup({
	cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(pid) },
  single_file_support = true,
})

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

capabilities.offsetEncoding = {"utf-16"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup {blabla}
