vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("mason").setup()
require("mason-lspconfig").setup()

require "nvchad.autocmds"
require('command-completion').setup()
require('mini.animate').setup {
    scroll = { enable = false }
}

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup {
    indent = { highlight = highlight },
    scope = { enabled = true }
}
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

local opts = { noremap=true, silent=true }
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.api.nvim_set_keymap('n', '<Leader>blame', ':BlameToggle virtual<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', require('fzf-lua').builtin, { desc = "fzf builtins" })
vim.keymap.set('n', '<C-a>', require('fzf-lua').lsp_code_actions, { desc = "fzf lsp code actions" })
vim.keymap.set('n', '<Leader>ccc', require('fzf-lua').grep_cword, { desc = "fzf cword" })
vim.keymap.set('n', '<Leader>CCC', require('fzf-lua').grep_cWORD, { desc = "fzf cWORD" })
vim.keymap.set('n', '<leader>qf', quickfix, opts)

vim.cmd [[ autocmd BufRead,BufNewFile *.S set filetype=asm ]]

vim.schedule(function()
  require "mappings"
end)
