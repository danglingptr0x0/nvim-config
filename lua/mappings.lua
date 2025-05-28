require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", ":wq", ":lua vim.defer_fn(function() vim.api.nvim_exec('qa!', false) end, 50)<CR>",
    { desc = "Quit without extra newline" })
map("n", "<leader>t", ":FloatermToggle<CR>", { desc = "Toggle floating terminal" })
map("n", "<leader>g", ":LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<leader>z", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })
map("n", "<leader>sr", ":Spectre<CR>", { desc = "Search and replace" })
map("n", "<leader>gd", function()
    local lib = require("diffview.lib")
    local view = lib.get_current_view()
    if view then
        vim.cmd("DiffviewClose")
    else
        vim.cmd("DiffviewOpen")
    end
end, { desc = "Toggle Git diff" })
map("n", "<leader>k", ":Telescope keymaps<CR>", { desc = "Show all keymaps in a searchable list" })
map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undo tree" })

local keymaps = {
    { key = "H",          cmd = "^",                             desc = "Move to beginning of line" },
    { key = "L",          cmd = "g_",                            desc = "Move to end of line (excluding newline)" },
    { key = "J",          cmd = "5j",                            desc = "Move down 5 lines" },
    { key = "W",          cmd = "w",                             desc = "Move to next word" },
    { key = "B",          cmd = "b",                             desc = "Move to previous word" },
    { key = "<C-d>",      cmd = "<C-d>zz",                       desc = "Scroll down half a page & center" },
    { key = "<C-u>",      cmd = "<C-u>zz",                       desc = "Scroll up half a page & center" },
    { key = "n",          cmd = "nzzzv",                         desc = "Next search result (centered)" },
    { key = "N",          cmd = "Nzzzv",                         desc = "Previous search result (centered)" },

    { key = "U",          cmd = "<C-r>",                         desc = "Redo" },
    { key = "Y",          cmd = "y$",                            desc = "Yank to end of line" },
    { key = "x",          cmd = "x",                             desc = "Delete character (copies)" },
    { key = "X",          cmd = "dd",                            desc = "Delete line (copies)" },
    { key = "dd",         cmd = "dd",                            desc = "Delete line (copies)" },
    { key = "<leader>p",  cmd = '"0p',                           desc = "Paste last yanked text" },
    { key = "<leader>P",  cmd = '"0P',                           desc = "Paste last yanked text (before cursor)" },

    { key = "viw",        cmd = "viw",                           desc = "Select current word" },
    { key = "vaW",        cmd = "vaW",                           desc = "Select current WORD (includes punctuation)" },
    { key = "V",          cmd = "V",                             desc = "Select entire line" },
    { key = "vip",        cmd = "vip",                           desc = "Select inside paragraph" },
    { key = "vis",        cmd = "vi{",                           desc = "Select inside braces `{}`" },
    { key = "viv",        cmd = "vi(",                           desc = "Select inside parentheses `()`" },
    { key = "viq",        cmd = 'vi"',                           desc = "Select inside double quotes `\"`" },
    { key = "<leader>sw", cmd = "*N",                            desc = "Search for current word" },

    { key = "<",          cmd = "<<",                            desc = "Indent left" },
    { key = ">",          cmd = ">>",                            desc = "Indent right" },
    { key = "<leader>f",  cmd = ":lua vim.lsp.buf.format()<CR>", desc = "Format code (LSP)" },

    { key = "<leader>bn", cmd = ":bnext<CR>",                    desc = "Next buffer" },
    { key = "<leader>bp", cmd = ":bprevious<CR>",                desc = "Previous buffer" },
    { key = "<leader>bd", cmd = ":bdelete<CR>",                  desc = "Close current buffer" },

    { key = "<leader>gd", cmd = ":DiffviewOpen<CR>",             desc = "Toggle Git diff view" },
    { key = "<leader>gb", cmd = ":Git blame<CR>",                desc = "Show Git blame" },

    { key = "<leader>e",  cmd = ":NvimTreeToggle<CR>",           desc = "Toggle file explorer" },
    { key = "<leader>km", cmd = ":Telescope keymaps<CR>",        desc = "Search keymaps" },
    { key = "<leader>sr", cmd = ":Spectre<CR>",                  desc = "Search and replace" },
}

for _, m in ipairs(keymaps) do
    map("n", m.key, m.cmd, { noremap = true, silent = true, desc = m.desc })
end
