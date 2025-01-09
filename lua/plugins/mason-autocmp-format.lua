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

			-- Ensure Mason installs the necessary tools
			local mason_registry = require("mason-registry")
			local ensure_installed = {
				"cppcheck", -- C++ linter
				"cpplint", -- C++ linter
				"pylint", -- Python linter
				"mypy", -- Python type checker
				"ruff", -- Python linter
				"cmakelint", -- CMake linter
				"eslint_d", -- JavaScript/TypeScript linter
				-- formatters
				"prettier",
				"prettierd",
				"stylua",
				"clang-format",
			}

			-- Automatically install if not already installed
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
	-- formatter.nvim configuration for code formatting
	{
		"mhartington/formatter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Detect platform once to avoid repeated checks
			local is_windows = vim.loop.os_uname().sysname:match("Windows")
			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
			local shell_cmd = is_windows and "cmd.exe" or "/bin/bash"

			-- Set shell globally (once)
			vim.o.shell = shell_cmd

			-- Helper function for reusable executable path resolution
			local executables = {
				prettier = mason_bin .. (is_windows and "/prettier.cmd" or "/prettier"),
				clang_format = mason_bin .. (is_windows and "/clang-format.cmd" or "/clang-format"),
				stylua = mason_bin .. (is_windows and "/stylua.cmd" or "/stylua"),
			}

			require("formatter").setup({
				filetype = {
					python = {
						function()
							return {
								exe = executables.prettier, -- Use pre-resolved path
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "python" },
								stdin = true,
							}
						end,
					},
					c = {
						function()
							return {
								exe = executables.clang_format,
								args = { "--style=Google" },
								stdin = true,
							}
						end,
					},
					cpp = {
						function()
							return {
								exe = executables.clang_format,
								args = { "--style=Google" },
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
					javascript = {
						function()
							return {
								exe = executables.prettier,
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "babel" },
								stdin = true,
							}
						end,
					},
					typescript = {
						function()
							return {
								exe = executables.prettier,
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "typescript" },
								stdin = true,
							}
						end,
					},
				},
			})

			-- Use more specific autocommand patterns for FormatWrite
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.lua", "*.py", "*.c", "*.cpp", "*.js", "*.ts" },
				command = "FormatWrite",
			})
		end,
	},
}
