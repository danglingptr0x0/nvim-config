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
    -- {
    --     dir = "~/.config/nvim/lua",
    --     name = "codejacker",
    --     lazy = false,
    --     config = function()
    --         require("codejacker")
    --     end,
    -- },
    {
        "jedrzejboczar/possession.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("possession").setup({
                autosave = true,
                autoload = true,
                silent = false,
                session_dir = vim.fn.stdpath("data") .. "/sessions/",
            })
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
        "mbbill/undotree",
	    lazy = false,
    },
    {
        dir = "/home/simtoon/git/Δ.nvim",
        name = "Δ",
        event = "VeryLazy",
        config = function()
        end
    },
    {
        "danarth/sonarlint.nvim"
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup {
                diff_opts = { internal = true },
                word_diff = true,
                signs = {
                    add          = { text = "┃" },
                    change       = { text = "┃" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                signcolumn         = true,
                numhl              = true,
                linehl             = false,
                show_deleted       = false,
                current_line_blame = true,
                current_line_blame_opts = {
                    delay         = 100,
                    virt_text_pos = "eol",
                },
                watch_gitdir       = { follow_files = true },
                attach_to_untracked = true,
            }

            local hl = vim.api.nvim_set_hl

            hl(0, "GitSignsAdd",    { fg = "#FF00FF", bg = "NONE" })
            hl(0, "GitSignsChange", { fg = "#FFFF00", bg = "NONE" })
            hl(0, "GitSignsDelete", { fg = "#FF0000", bg = "NONE" })

            hl(0, "GitSignsAddNr",    { fg = "#FF00FF", bg = "NONE" })
            hl(0, "GitSignsChangeNr", { fg = "#FFFF00", bg = "NONE" })
            hl(0, "GitSignsDeleteNr", { fg = "#FF0000", bg = "NONE" })
            --
            -- hl(0, "GitSignsAddLn",    { bg = "#FF00FF" })
            -- hl(0, "GitSignsChangeLn", { bg = "#FFFF00" })
            -- hl(0, "GitSignsDeleteLn", { bg = "#FF0000" })

            hl(0, "GitSignsAddInline",    { fg = "#FF00FF", bg = "NONE" })
            hl(0, "GitSignsChangeInline", { fg = "#FFFF00", bg = "NONE" })
            hl(0, "GitSignsDeleteInline", { fg = "#FF0000", bg = "NONE" })

            hl(0, "GitSignsAddLnInline",    { fg = "#FF00FF", bg = "NONE" })
            hl(0, "GitSignsChangeLnInline", { fg = "#FFFF00", bg = "NONE" })
            hl(0, "GitSignsDeleteLnInline", { fg = "#FF0000", bg = "NONE" })

            hl(0, "GitSignsAddVirtLnInline",    { fg = "#FF00FF", bg = "NONE" })
            hl(0, "GitSignsChangeVirtLnInline", { fg = "#FFFF00", bg = "NONE" })
            hl(0, "GitSignsDeleteVirtLnInline", { fg = "#FF0000", bg = "NONE" })
        end,
    },
    {
        "voldikss/vim-floaterm",
        lazy = false
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
        	require("neoscroll").setup()
        end,
        lazy = false
    },
    {
        "echasnovski/mini.animate",
        version = "*",
        lazy = false,
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        lazy = false,
        opts = {
            text = {
                editing = function(opts)
                    local mode = vim.api.nvim_get_mode().mode
                    local mode_label = ({
                        i = "INS",
                        v = "VIS",
                        V = "V-LN",
                        ["\22"] = "V-BLK",
                        n = "NORM",
                    })[mode] or "OTHER"

                    return string.format("[%s] %s:%s of %s", mode_label, opts.cursor_char, opts.cursor_line, opts.filename)
                end,

                workspace = function()
                    local bufnr = 0
                    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                    local todos, fixmes = 0, 0

                    for _, line in ipairs(lines) do
                        if line:match("TODO") then todos = todos + 1 end
                        if line:match("FIXME") then fixmes = fixmes + 1 end
                    end

                    local err  = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
                    local warn = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })

                    return string.format("todo: %d; fixme: %d | err: %d; warn: %d", todos, fixmes, err, warn)
                end,
            }
        },
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({})
        end,
        lazy = false
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("diffview").setup()
        end,
        lazy = false,
    },
    {
        "szw/vim-maximizer",
        lazy = false,
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
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
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
		        "vhdl",
                "verilog",
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
	"kdheepak/lazygit.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false
    },
    {
        "RRethy/vim-illuminate",
        lazy = false,
    },
    {
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
        lazy = false,
    },
    {
        "pocco81/auto-save.nvim",
        lazy = false,
        config = function ()
            require("auto-save").setup({
                trigger_events = {"InsertLeave", "TextChanged"},
                debounce_delay = 5000,
            })
        end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },
    {
        "rcarriga/nvim-notify",
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
                "~/git/work/teddy/mod_engram_manager",
                "~/git/work/teddy/mod_stt_transcript_proofreader",
                "~/git/work/teddy/mod_only_interrupt_and_respond_if_addressed",
                "~/git/work/teddy/mod_wakeword_trigger",
                "~/git/work/teddy/mod_basic_ddg_websearch",
                "~/git/work/teddy/mod_reminders",
                "~/git/work/teddy/mod_tavily_search",
                "~/git/work/teddy/teddy_logger/",
                "~/git/work/teddy/teddy/",
                "~/git/work/teddy/mod_calendar/",
                "~/git/work/codejacker/",
                "~/git/work/codejacker_server/",
                "~/git/work/codejacker.nvim/",
                "~/git/dangling/",
                "~/git/HeapZy/",
                "~/git/cuT/",
                "~/git/ti_rackjacker",
                "~/git/mathNStuff",
                "~/git/kaybeestat_DKMS"
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
    ---@module "neominimap.config.meta"
    {
        "Isrothy/neominimap.nvim",
      version = "v3.x.x",
      lazy = false, -- NOTE: NO NEED to Lazy load
      -- Optional. You can alse set your own keybindings
      -- keys = {
      --   -- Global Minimap Controls
      --   { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
      --   { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
      --   { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
      --   { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
      --
      --   -- Window-Specific Minimap Controls
      --   { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
      --   { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
      --   { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
      --   { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
      --
      --   -- Tab-Specific Minimap Controls
      --   { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
      --   { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
      --   { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
      --   { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },
      --
      --   -- Buffer-Specific Minimap Controls
      --   { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
      --   { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      --   { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
      --   { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
      --
      --   ---Focus Controls
      --   { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
      --   { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
      --   { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
      -- },
      init = function()
        -- The following options are recommended when layout == "float"
        vim.opt.wrap = false
        vim.opt.sidescrolloff = 36 -- Set a large value

        --- Put your configuration here
        ---@type Neominimap.UserConfig
        vim.g.neominimap = {
          auto_enable = true,
        }
      end,
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
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function ()
            require("octo").setup()
        end,
        lazy = false,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        lazy = false
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
