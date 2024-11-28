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
				"prettier",
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
					"ts_ls", -- JavaScript/TypeScript LSP (deprecated tsserver)
				},
			})

			local lspconfig = require("lspconfig")

			-- Keybindings for LSP functionality
			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.api.nvim_buf_set_keymap(
						bufnr,
						"n",
						keys,
						"",
						{ noremap = true, silent = true, callback = func, desc = desc }
					)
				end

				-- Keybindings for LSP functions
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
				map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
				map("<leader>ps", vim.lsp.buf.workspace_symbol, "[P]roject [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
				map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
				map("<leader>e", vim.diagnostic.open_float, "Open diagnostic")
			end

			-- Setup LSP servers with on_attach for keybindings
			lspconfig.clangd.setup({ on_attach = on_attach })
			lspconfig.cmake.setup({ on_attach = on_attach })
			lspconfig.pylsp.setup({ on_attach = on_attach })
			lspconfig.zls.setup({ on_attach = on_attach })
			lspconfig.ts_ls.setup({ on_attach = on_attach })
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
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
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
