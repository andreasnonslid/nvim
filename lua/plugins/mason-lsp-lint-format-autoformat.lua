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

			-- Make sure mason installs the linters and tools you need
			local mason_registry = require("mason-registry")
			local ensure_installed = {
				"cppcheck", -- C++ linter
				"cpplint", -- C++ linter
				"pylint", -- Python linter
				"mypy", -- Python type checker
				"ruff", -- Python linter
				"cmakelint", -- CMake linter
				"eslint_d", -- JavaScript linter
				"prettier", -- JavaScript/TypeScript/HTML/CSS formatter
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
	-- Mason-LSPConfig to bridge Mason and nvim-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"cmake",
					"pylsp",
					"zls",
					"ts_ls", -- JavaScript/TypeScript LSP
				},
			})

			local lspconfig = require("lspconfig")

			-- Setup LSP servers
			lspconfig.clangd.setup({})
			lspconfig.cmake.setup({})
			lspconfig.pylsp.setup({})
			lspconfig.zls.setup({})
			lspconfig.ts_ls.setup({}) -- JavaScript/TypeScript LSP
		end,
	},
	-- nvim-lint configuration for linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Configure linters for each filetype
			lint.linters_by_ft = {
				c = { "cpplint" },
				cpp = { "cppcheck", "cpplint" },
				python = { "ruff", "pylint", "mypy" },
				cmake = { "cmakelint" },
				javascript = { "eslint_d" }, -- JavaScript linter
				typescript = { "eslint_d" }, -- TypeScript linter
			}

			-- Setup autocmd to lint on file save
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	-- formatter.nvim configuration for code formatting
	{
		"mhartington/formatter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("formatter").setup({
				filetype = {
					python = {
						function()
							return {
								exe = "prettier",
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "python" },
								stdin = true,
							}
						end,
					},
					c = {
						function()
							return {
								exe = "clang-format",
								args = { "--style=Google" },
								stdin = true,
							}
						end,
					},
					cpp = {
						function()
							return {
								exe = "clang-format",
								args = { "--style=Google" },
								stdin = true,
							}
						end,
					},
					lua = {
						function()
							return {
								exe = "stylua",
								args = { "-" },
								stdin = true,
							}
						end,
					},
					javascript = {
						function()
							return {
								exe = "prettier",
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "babel" },
								stdin = true,
							}
						end,
					},
					typescript = {
						function()
							return {
								exe = "prettier",
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
	-- nvim-cmp for autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- text in buffer
			"hrsh7th/cmp-path", -- file system paths
			"hrsh7th/cmp-nvim-lsp", -- LSP completion
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- LuaSnip autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets library
			"onsails/lspkind.nvim", -- vs-code like pictograms
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
}
