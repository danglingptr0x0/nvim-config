local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
  "bashls",
  "clangd",
  "ast_grep",
  -- "harper_ls"
}

require('sonarlint').setup({
   server = {
      cmd = {
         'sonarlint-language-server',
         '-stdio',
         '-analyzers',
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      },
      settings = {
         sonarlint = {
            rules = {
               ['typescript:S101'] = { level = 'on', parameters = { format = '^[A-Z][a-zA-Z0-9]*$' } },
            }
         }
      }
   },
   filetypes = {
      'cpp',
      'c',
      "h",
      "hpp"
   },
   autostart = true
})

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
-- lspconfig.harper_ls.setup{}
lspconfig.ast_grep.setup{}
