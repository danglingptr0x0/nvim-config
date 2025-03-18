local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

capabilities.textDocument.inlayHint = { dynamicRegistration = false }

local lspconfig = require("lspconfig")
local servers = {
  "bashls",
  "clangd",
  "ast_grep",
  "asm_lsp"
  -- "harper_ls"
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint(args.buf, true)
        end
    end,
})

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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            if type(vim.lsp.inlay_hint) == "function" then
                vim.lsp.inlay_hint(args.buf, true)
            elseif type(vim.lsp.inlay_hint.enable) == "function" then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            else
                print("Error: `vim.lsp.inlay_hint` is not a function or does not exist!")
            end
        end
    end,
})

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            require("lsp_signature").on_attach({
                bind            = true,
                floating_window = false,
                hint_enable     = true,
                hint_prefix     = "󰆧 ",
                hint_scheme     = "Comment",
                hi_parameter    = "Search",
                always_trigger  = true,
            }, bufnr)
        end,
        on_init = on_init,
        capabilities = capabilities,
    }
end

lspconfig.bashls.setup{}
lspconfig.clangd.setup {
    cmd = { "clangd", "--log=verbose", "--header-insertion=never", "--clang-tidy", "--completion-style=detailed", "--inlay-hints" },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        else
            print("Warning: Clangd does not support `inlayHintProvider`!")
        end
    end,
    capabilities = capabilities,
}
-- lspconfig.harper_ls.setup{}
lspconfig.ast_grep.setup{}
