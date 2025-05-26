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
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = true,
			}
		end,
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
				stylua = mason_bin .. (is_windows and "/stylua.cmd" or "/stylua"),
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
