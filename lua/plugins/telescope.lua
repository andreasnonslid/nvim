return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            local builtin = require("telescope.builtin")
            -- Update the keybindings from <leader>s to <leader>f
            vim.keymap.set(
                "n",
                "<leader>fh",
                builtin.help_tags,
                { desc = "[F]ind [H]elp" }
            )
            vim.keymap.set(
                "n",
                "<leader>fk",
                builtin.keymaps,
                { desc = "[F]ind [K]eymaps" }
            )
            vim.keymap.set(
                "n",
                "<leader>ff",
                builtin.find_files,
                { desc = "[F]ind [F]iles" }
            )
            vim.keymap.set(
                "n",
                "<leader>fs",
                builtin.builtin,
                { desc = "[F]ind [S]elect Telescope" }
            )
            vim.keymap.set(
                "n",
                "<leader>fw",
                builtin.grep_string,
                { desc = "[F]ind current [W]ord" }
            )
            vim.keymap.set(
                "n",
                "<leader>fg",
                builtin.live_grep,
                { desc = "[F]ind by [G]rep" }
            )
            vim.keymap.set(
                "n",
                "<leader>fd",
                builtin.diagnostics,
                { desc = "[F]ind [D]iagnostics" }
            )
            vim.keymap.set(
                "n",
                "<leader>fr",
                builtin.resume,
                { desc = "[F]ind [R]esume" }
            )
            vim.keymap.set(
                "n",
                "<leader>f.",
                builtin.oldfiles,
                { desc = '[F]ind Recent Files ("." for repeat)' }
            )
            vim.keymap.set(
                "n",
                "<leader><leader>",
                builtin.buffers,
                { desc = "[ ] Find existing buffers" }
            )
            vim.keymap.set(
                "n",
                "<leader>ft",
                "<cmd>TodoTelescope<cr>",
                { desc = "[F]ind [T]odos" }
            )
            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({
                        layout_config = {
                            width = 0.9,
                            height = 0.7,
                        },
                        winblend = 10,
                        previewer = false,
                    })
                )
            end, { desc = "[/] Fuzzily search in current buffer" })
            vim.keymap.set("n", "<leader>fn", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "[F]ind [N]eovim files" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
}
