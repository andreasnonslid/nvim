return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "prettier" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                sh = { "prettier" },
                yaml = { "prettier" },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 1000,
                async = false,
                lsp_fallback = true,
            },
        })
    end,
}
