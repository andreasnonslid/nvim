return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]roject", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]ab", _ = "which_key_ignore" },
			["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
		})
		-- visual mode
		require("which-key").register({
			["<leader>h"] = { "Git [H]unk" },
		}, { mode = "v" })
	end,
}
