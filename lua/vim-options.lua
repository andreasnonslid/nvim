-- Set language
vim.cmd("language en_US.utf8")

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Toggle Nerd Font usage
vim.g.have_nerd_font = true

-- Enable relative and absolute line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- Enable persistent undo
vim.opt.undofile = true

-- Always show sign column
vim.opt.signcolumn = "yes"

-- Set command response update time in milliseconds
vim.opt.updatetime = 250

-- Set timeout lengths for key sequences
vim.opt.timeoutlen = 300
vim.o.timeoutlen = 300 -- duplicated setting

-- Visual options for whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preferences for window splitting behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show effects of command incrementally
vim.opt.inccommand = "split"

-- Highlight the screen line of the cursor
vim.opt.cursorline = true

-- Set the number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Highlight search results
vim.opt.hlsearch = true

-- Key sequence timeout
vim.o.timeout = true

-- Set auto-indenting
vim.opt.autoindent = true

-- Set tabulation characteristics
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Disable text wrapping
vim.opt.wrap = false

-- Case sensitivity in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure backspace behavior
vim.opt.backspace = "indent,eol,start"

-- Enable terminal GUI colors
vim.opt.termguicolors = true

-- Customize cursor line highlight in terminal and GUI
vim.cmd("highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40")
