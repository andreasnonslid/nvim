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
			local is_windows = vim.loop.os_uname().sysname:match("Windows")

			-- Helper function to get the path dynamically
			local function get_executable_path(tool)
				local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
				if is_windows then
					return mason_bin .. "/" .. tool .. ".cmd"
				else
					return mason_bin .. "/" .. tool
				end
			end

			if vim.fn.has("win32") == 1 then
				vim.o.shell = "cmd.exe"
			else
				vim.o.shell = "/bin/bash"
			end

			require("formatter").setup({
				filetype = {
					python = {
						function()
							return {
								exe = get_executable_path("prettier"), -- Dynamically locate prettier
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "python" },
								stdin = true,
							}
						end,
					},
					c = {
						function()
							return {
								exe = get_executable_path("clang-format"), -- Dynamically locate clang-format
								args = { "--style=Google" },
								stdin = true,
							}
						end,
					},
					cpp = {
						function()
							return {
								exe = get_executable_path("clang-format"), -- Dynamically locate clang-format
								args = { "--style=Google" },
								stdin = true,
							}
						end,
					},
					lua = {
						function()
							return {
								exe = get_executable_path("stylua"), -- Dynamically locate stylua
								args = { "-" },
								stdin = true,
							}
						end,
					},
					javascript = {
						function()
							return {
								exe = get_executable_path("prettier"), -- Dynamically locate prettier
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "babel" },
								stdin = true,
							}
						end,
					},
					typescript = {
						function()
							return {
								exe = get_executable_path("prettier"), -- Dynamically locate prettier
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "typescript" },
								stdin = true,
							}
						end,
					},
				},
			})

			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
				command = "FormatWrite",
			})
		end,
	},
}
