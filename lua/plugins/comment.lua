return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("Comment").setup({
			mappings = {
				basic = false, -- Disable the default 'gc' and 'gcc' mappings
				extra = false, -- Disable extra mappings like 'gco', 'gcO', 'gcA'
			},
		})
	end,
}
