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
require("set-mason-git-dirs-safe")

require("lazy").setup("plugins", { debug = true }, { change_detection = { notify = false } })

-- My lazily added custom functions
require("jump-to-matching-line")
require("search-for-numbers")
require("markdown-helpers")
