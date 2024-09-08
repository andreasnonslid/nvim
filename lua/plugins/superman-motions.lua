return {
	{
		"ggandor/flit.nvim",
		enabled = true,
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		enabled = true,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
		},
		config = function()
			local leap = require("leap")

			leap.add_default_mappings(true)

			leap.opts.safe_labels = { "s", "S", "gs" }
			leap.opts.case_sensitive = true

			-- Clear unwanted mappings if necessary
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	{ "tpope/vim-repeat", event = "VeryLazy" },
}
