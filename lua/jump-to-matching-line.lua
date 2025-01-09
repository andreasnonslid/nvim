-- Map <leader>n to search for the current line
vim.api.nvim_set_keymap(
	"n",
	"<leader>n",
	[[:let @/='\V'.escape(getline('.'), '\\/.*$^~[]')<CR>/<CR>]],
	{ desc = "[N]ext identical line", noremap = true, silent = true }
)
