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

local function insert_mod_template()
    local lines = {
        '#include "mod.h"',
        '#include <stdio.h>',
        '#include <string.h>',
        '#include "cJSON.h"',
        '#include "shared_interop.h"',
        "",
        "static mod dummy_mod;",
        "",
        "const char* dummy_exec_task(void **input, size_t *size)",
        "{",
        "    if (!input || !*input || !*size)",
        "    {",
        '        fprintf(stderr, "%s: invalid input!\\n", dummy_mod.name);',
        '        return strdup("failure: couldn\'t parse JSON!");',
        "    }",
        "",
        '    printf("recv input: %s\\n", (char *)*input);',
        "    cJSON *json = cJSON_Parse((char *)*input);",
        "    if (!json)",
        "    {",
        '        fprintf(stderr, "%s: invalid JSON!\\n", dummy_mod.name);',
        '        return strdup("failure: invalid JSON!");',
        "    }",
        "",
        "    cJSON *city = cJSON_GetObjectItemCaseSensitive(json, \"city\");",
        "    if (cJSON_IsString(city) && (city->valuestring))",
        "    {",
        '        printf("%s: the weather in %s is ... no idea!!\\n", dummy_mod.name, city->valuestring);',
        "        cJSON_Delete(json);",
        '        return strdup("sunny");',
        "    }",
        "    else",
        "    {",
        '        fprintf(stderr, "%s: got no city!\\n", dummy_mod.name);',
        "    }",
        "    cJSON_Delete(json);",
        '    return strdup("failure: unknown error!");',
        "}",
        "",
        "void mod_shutdown(void) {}",
        "",
        "int mod_init(void)",
        "{",
        '    static const char *provides[] = { "weather_for_city" };',
        '    static const char *expects[] = { "city" };',
        '    static const char *hooks[] = { "check_weather" };',
        "",
        "    static mod_reg reg =",
        "        {",
        '            .task_type = "weather_for_city",',
        "            .exec_task = dummy_exec_task,",
        "            .provides = provides,",
        "            .n_provides = 1,",
        "            .expects = expects,",
        "            .n_expects = 1",
        "        };",
        "",
        "    dummy_mod =",
        "        (mod)",
        "            {",
        '                .name = "DummyWeatherMod",',
        '                .desc = "A dummy mod made for development purposes.",',
        "                .revision = 2,",
        "                .reg = &reg,",
        "                .init = mod_init,",
        "                .shutdown = mod_shutdown",
        "            };",
        "",
        "    register_mod(&dummy_mod);",
        "",
        '    printf("%s: param overriden!\\n", dummy_mod.name);',
        '    glob_reg->llm_name = "gpt-3.5-turbo";',
        '    printf("%s: new val: %s\\n", dummy_mod.name, glob_reg->llm_name);',
        "",
        "    return 0;",
        "}"
    }
    vim.api.nvim_put(lines, "l", true, true)
end

vim.api.nvim_create_user_command(
    'ModTemplate',
    function() insert_mod_template() end,
    { desc = 'Insert the full mod template code' }
)

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
vim.cmd [[ autocmd BufRead,BufNewFile *.s set filetype=asm ]]

vim.schedule(function()
  require "mappings"
end)
