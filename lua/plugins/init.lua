return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "dense-analysis/ale",
        config = function()
            -- Configuration goes here.
            local g = vim.g

            g.ale_ruby_rubocop_auto_correct_all = 1

            -- g.ale_linters = {
            -- ruby = {'rubocop', 'ruby'},
            -- lua = {'lua_language_server'}
            -- }
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
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- vim
                "lua-language-server",
                "stylua",
                "clangd",
                "cpptools",
                "cpplint",
                "clang-format",
                -- web
                "json-lsp",
                -- other
                "markdownlint",
                "prettier",
            },
        },
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
                "~/git/work/teddy/teddy_whisper_server/",
                "~/git/work/teddy/theoverseer/",
                "~/git/HeapZy/",
                "~/git/cuT/",
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
