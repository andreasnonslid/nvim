return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "ruff" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				sh = { "prettier" },
				tex = { "prettier" },
				cmake = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
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
