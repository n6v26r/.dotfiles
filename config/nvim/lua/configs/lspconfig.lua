require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
-- local pid = vim.fn.getpid()

-- Faster csharp_ls load time with omnisharp disabled. Enable it, and remove csharp_ls from server list 
-- if you would like to use omni (which also has singe file support). In my exp, omnisharp is slower.
-- lspconfig.omnisharp.setup({
-- 	cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll"},
--   single_file_support = true,
--   analyze_open_documents_only = true,
-- })

-- if you just want default config for the servers then put them in a table

local servers = { "html", "cssls", "ts_ls", "clangd", "marksman", "csharp_ls", "volar", "pyright", "gopls", "textlsp"}

local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.capabilities.offsetEncoding = {"utf-16"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- lspconfig.pyright.setup {}

lspconfig.texlab.setup{}

