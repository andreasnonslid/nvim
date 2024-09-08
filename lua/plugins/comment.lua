return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("Comment").setup({
			mappings = {
				basic = false, -- disable default bindings
			},
		})

		-- Remove any existing mappings for `gc`
		vim.api.nvim_del_keymap("n", "gc")
		vim.api.nvim_del_keymap("n", "gcc")
	end,
}
