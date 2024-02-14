vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent smartindent")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set relativenumber")
vim.cmd("set number")
vim.cmd("set cursorline")
vim.cmd("set nowrap")

vim.cmd("highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40")

-- removes the ^M line endings when copying from windows to wsl
vim.api.nvim_set_keymap("n", "<leader>cm", ":let @/ = ''<CR>:%s/\\r//g<CR>", { noremap = true, silent = true })

-- copy path to current buffer to system clipboard
vim.api.nvim_set_keymap("n", "<leader>ybn", ":let @+ = expand(' % ')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>yfp", ":let @+ = expand('%:p')<CR>", { noremap = true, silent = true })
