return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	keys = {
		{ "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "Toggle Trouble list" },
		{ "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
		{ "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document diagnostics" },
		{ "<leader>tq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix list" },
		{ "<leader>tl", "<cmd>TroubleToggle loclist<CR>", desc = "Location list" },
		{ "<leader>tx", "<cmd>TodoTrouble<CR>", desc = "Todos in Trouble" },
	},
}
