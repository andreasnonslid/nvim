vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent smartindent")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set relativenumber")
vim.cmd("set number")
vim.cmd("set cursorline")

vim.cmd("highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40")

vim.api.nvim_set_keymap("n", "<leader>cm", ':%s/\r//g<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>cm", ':%s/\r//g<CR>', { noremap = true, silent = true })
