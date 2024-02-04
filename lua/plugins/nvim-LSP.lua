return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
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
					"powershell_es",
					"ruff_lsp",
					"rust_analyzer",
					"taplo",
					"yamlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})

			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, opts, { desc = "LSP Goto Reference" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts, { desc = "LSP Workspace Symbol" })
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.setloclist()
			end, opts, { desc = "LSP Show Diagnostics" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts, { desc = "Next Diagnostic" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts, { desc = "Previous Diagnostic" })
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts, { desc = "LSP Code Action" })
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end, opts, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts, { desc = "LSP Rename" })
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts, { desc = "LSP Signature Help" })
		end,
	},
}
