-- Rose-pine
return {
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("rose-pine").setup({})
	--
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },
	{
		"marko-cerovac/material.nvim",
		name = "material",
		priority = 1000,
		config = function()
			require("material").setup({
				plugins = {
					"gitsigns",
					"harpoon",
					"indent-blankline",
					"mini",
					"noice",
					"nvim-tree",
					"nvim-web-devicons",
					"telescope",
					"trouble",
					"which-key",
				},
			})
			vim.g.material_style = "deep ocean"
			vim.cmd.colorscheme("material")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				theme = "material",
			})
		end,
	},
}
