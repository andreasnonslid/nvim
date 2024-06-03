local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("vim-keybinds")

require("lazy").setup("plugins", { debug = true }, { change_detection = { notify = false } })

-- Function to jump to the next line with the same content
function JumpToNextMatchingLine()
	local current_line = vim.api.nvim_get_current_line()
	local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)

	for i = current_line_num + 1, total_lines do
		if vim.fn.getline(i) == current_line then
			vim.api.nvim_win_set_cursor(0, { i, 0 })
			return
		end
	end

	for i = 1, current_line_num do
		if vim.fn.getline(i) == current_line then
			vim.api.nvim_win_set_cursor(0, { i, 0 })
			return
		end
	end

	print("No matching line found")
end

-- Map <leader>n to the JumpToNextMatchingLine function
vim.api.nvim_set_keymap("n", "<leader>n", ":lua JumpToNextMatchingLine()<CR>", { noremap = true, silent = true })
