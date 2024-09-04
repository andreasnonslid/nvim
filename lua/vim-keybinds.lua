vim.api.nvim_set_keymap("i", "jk", "<ESCAPE>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>w<CR>", { noremap = true, silent = true })

-- removes the ^M line endings when copying from windows to wsl
vim.api.nvim_set_keymap(
	"n",
	"<leader>cm",
	":let @/ = ''<CR>:%s/\\r//g<CR>",
	{ noremap = true, silent = true, desc = "Removes [C]opied line endings [M]^ from file." }
)

-- -- copy path to current buffer to system clipboard
-- vim.api.nvim_set_keymap("n", "<leader>ybn", ":let @+ = expand(' % ')<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>yfp", ":let @+ = expand('%:p')<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "[+] Increment number" })
-- vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "[-] Decrement number" })

-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- vim.keymap.set("n", "<leader>vv", "<C-w>v", { desc = "Split [V]iewport [V]ertically" })
-- vim.keymap.set("n", "<leader>vh", "<C-w>s", { desc = "Split [V]iewport [H]orizontally" })
-- vim.keymap.set("n", "<leader>ve", "<C-w>=", { desc = "Make [V]iewport [E]qual size" })
-- vim.keymap.set("n", "<leader>vx", "<cmd>close<CR>", { desc = "Close current [V]iewport [X]" })
--
-- vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab [O]pen" })
-- vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab Close" })
-- vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext" })
-- vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab [P]revious" })
-- vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "[T]ab" })
