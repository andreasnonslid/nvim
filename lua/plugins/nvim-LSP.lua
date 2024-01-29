return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "cmake",
                    "clangd",
                    "dockerls",
                    "jsonls",
                    "tsserver",
                    "ltex",
                    "marksman",
                    "matlab_ls",
                    "powershell_es",
                    "ruff_lsp",
                    "rust_analyzer",
                    "taplo",
                    "yamlls",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.cmake.setup({})
            lspconfig.clangd.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.tsserver.setup({})
            lspconfig.ltex.setup({})
            lspconfig.marksman.setup({})
            lspconfig.matlab_ls.setup({})
            lspconfig.powershell_es.setup({})
            lspconfig.ruff_lsp.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.taplo.setup({})
            lspconfig.yamlls.setup({})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end
    }
}
