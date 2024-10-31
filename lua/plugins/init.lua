return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "danarth/sonarlint.nvim"
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({ fzf_colors = true })
        end
    },
    {
        "dense-analysis/ale",
        config = function()
            local g = vim.g

            g.ale_ruby_rubocop_auto_correct_all = 1

            g.ale_fixers = {
                cpp = {'uncrustify', 'trim_whitespace'},
                c = {'uncrustify', 'trim_whitespace'}
            }

            g.ale_linters = {
                lua = {'lua_language_server'},
                cpp = {'cppcheck', 'clangtidy', 'flawfinder', 'clangcheck', 'cpplint', 'clangd', 'sonarlint'},
                c = {'cppcheck', 'clangtidy', 'flawfinder', 'clangcheck', 'cpplint', 'clangd', 'sonarlint'}
            }

            g.ale_lint_on_save = 1
            g.ale_lint_on_enter = 1
            g.ale_lint_on_insert_leave = 1

            g.ale_virtualtext_cursor = 1
            g.ale_virtualtext = 1

            g.ale_sign_error = '✘'
            g.ale_sign_warning = '!'

            g.ale_hover_cursor = 1

            g.ale_cpp_uncrustify_config = '/usr/share/uncrustify/uncrustify.cfg'

            g.ale_cpp_cppcheck_options = '--enable=all --check-level=exhaustive --inconclusive --force --std=c99 --suppress=missingIncludeSystem'
            g.ale_cpp_clangtidy_options = '-I include'

            vim.api.nvim_create_user_command('Cppcheck', function()
                vim.cmd('!cppcheck --check-level=exhaustive --force --std=c99 --suppress=missingIncludeSystem --enable=all --inconclusive *')
            end, {})

            vim.api.nvim_create_user_command('ClangTidy', function()
                vim.cmd('!clang-tidy *.cpp -- -I include/')
            end, {})

            vim.api.nvim_create_user_command('Flawfinder', function()
                vim.cmd('!flawfinder *')
            end, {})

            vim.api.nvim_create_user_command('RunStaticChecks', function()
                vim.cmd('Cppcheck')
                vim.cmd('ClangTidy')
                vim.cmd('Flawfinder')
            end, {})

        end,
        lazy = false,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        lazy = false,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                -- vim
                "vim",
                "lua",
                "vimdoc",
                "json",
                -- low-level
                "c",
                "cpp",
                "cmake",
                "make",
                "asm",
                "gdscript",
                "cuda",
                "glsl",
                "hlsl",
                "bash",
                "bibtex",
                "llvm",
                -- system,
                "bash",
                -- other
                "latex",
                "markdown",
            },
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            "nvim-telescope/telescope.nvim", -- optional
        },
        lazy = false,
        config = true,
    },
    {
        "pocco81/auto-save.nvim",
        lazy = false,
        config = function ()
            require("auto-save").setup({
                trigger_events = {"InsertLeave", "TextChanged"},
                debounce_delay = 2500,
            })
        end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },
    {
        "ThePrimeagen/vim-be-good",
        lazy = false,
    },
    {
        "smolck/command-completion.nvim",
        lazy = false,
    },
    {
        "ldelossa/gh.nvim",
        dependencies = {
            {
                "ldelossa/litee.nvim",
                config = function()
                    require("litee.lib").setup()
                end,
            },
        },
        config = function()
            require("litee.gh").setup()
        end,
        lazy = false
    },
    {
        "coffebar/neovim-project",
        opts = {
            projects = { -- define project roots
                "~/git/work/teddy/teddy_core_runtime/",
                "~/git/work/teddy/theoverseer/",
                "~/git/work/teddy/teddy_unified_mod_interface",
                "~/git/work/teddy/teddy_core_server",
                "~/git/work/teddy/teddy_core_client",
                "~/git/work/teddy/teddy_core_python",
                "~/git/work/teddy/mod_dummy",
                "~/git/work/teddy/mod_media_control",
                "~/git/work/teddy/mod_python_compat_layer",
                "~/git/work/teddy/mod_personality_matrix_manager",
                "~/git/simtoon_os",
                "~/git/HeapZy/",
                "~/git/cuT/",
                "~/git/mathNStuff",
                "~/git/work/c9/phillipl-bot",
            },
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append "globals" -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
    },
    { -- This plugin
        "Zeioth/makeit.nvim",
        cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
        dependencies = { "stevearc/overseer.nvim" },
        opts = {},
    },
    {
        "danymat/neogen",
        config = true,
        lazy = false,
    },
    { -- The task runner we use
        "stevearc/overseer.nvim",
        commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
        cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
            },
        },
        lazy = false,
    },
    {
        "Zeioth/dooku.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "ldelossa/gh.nvim",
        dependencies = {
            {
                "ldelossa/litee.nvim",
                config = function()
                    require("litee.lib").setup()
                end,
            },
        },
        config = function()
            require("litee.gh").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        lazy = false,
    },
    { 'echasnovski/mini.animate', version = '*' },
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        opts = {
            blame_options = nil,
            views = {
                virtual = virtual_view,
                default = virtual_view
            },
            merge_consecutive = false,
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
    --- @module "ibl"
    --- @type ibl.config
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    --   'dense-analysis/ale',
    --   lazy = false,
    --   config = function()
    --       -- Configuration goes here.
    --       local g = vim.g
    --
    --       g.ale_linters = {
    --           lua = {'lua_language_server'},
    --           javascript = {'eslint'},
    --           typescript = {'eslint'}
    --       }
    --
    --   end
    -- }
}
