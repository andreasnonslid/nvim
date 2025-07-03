return {
    -- Mason for LSP management
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            local mason_registry = require("mason-registry")
            local ensure_installed = {
                "stylua",
            }

            for _, tool in ipairs(ensure_installed) do
                local ok, p = pcall(mason_registry.get_package, tool)
                if ok and not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "mhartington/formatter.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local is_windows = vim.loop.os_uname().sysname:match("Windows")
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
            local shell_cmd = is_windows and "cmd.exe" or "/bin/bash"

            vim.o.shell = shell_cmd

            local executables = {
                clang_format = "clang-format",
                stylua = mason_bin
                    .. (is_windows and "/stylua.cmd" or "/stylua"),
            }

            require("formatter").setup({
                filetype = {
                    c = {
                        function()
                            return {
                                exe = executables.clang_format,
                                -- args = { "--style=Google" },
                                stdin = true,
                            }
                        end,
                    },
                    cpp = {
                        function()
                            return {
                                exe = executables.clang_format,
                                -- args = { "--style=Google" },
                                stdin = true,
                            }
                        end,
                    },
                    lua = {
                        function()
                            return {
                                exe = executables.stylua,
                                args = { "-" },
                                stdin = true,
                            }
                        end,
                    },
                },
            })

            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.lua", "*.c", "*.cpp" },
                command = "FormatWrite",
            })
        end,
    },
}
