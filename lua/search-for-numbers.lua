-- Custom Number-Based Fuzzy Search for Telescope
-- Adds functionality to search for numbers less than or greater than a given input in the current buffer.

-- Ensure Telescope is available
local telescope = require("telescope.builtin")

-- Function to validate the input number
local function is_number(input)
	return tonumber(input) ~= nil
end

-- Function to build a precise fuzzy pattern
local function build_pattern(number, comparison)
	local num_str = tostring(number)
	local digits = #num_str
	local pattern_parts = {}

	-- Loop through each digit position in the input number
	for i = 1, digits do
		local current_digit = tonumber(num_str:sub(i, i))
		if current_digit then
			if comparison == "less" then
				table.insert(pattern_parts, string.format("[0-%d]", current_digit))
			elseif comparison == "more" then
				table.insert(pattern_parts, string.format("[%d-9]", current_digit))
			end
		end
	end

	-- Combine patterns for all positions
	local position_pattern = table.concat(pattern_parts)

	-- Add length condition based on comparison
	if comparison == "less" then
		-- Allow shorter numbers or exact matches to the length
		return string.format("\\b([0-9]{1,%d}|%s[0-9]*)\\b", digits - 1, position_pattern)
	elseif comparison == "more" then
		-- Allow longer numbers or exact matches to the length
		return string.format("\\b(%s[0-9]*)\\b", position_pattern)
	end

	return nil
end

-- Core search function
local function search_numbers(number, comparison)
	if not is_number(number) then
		vim.api.nvim_err_writeln("Invalid input: Please provide a valid number.")
		return
	end

	local pattern = build_pattern(number, comparison)
	if not pattern then
		vim.api.nvim_err_writeln("Failed to build search pattern.")
		return
	end

	telescope.grep_string({
		search = pattern,
		use_regex = true,
		search_dirs = { vim.fn.expand("%:p") }, -- Search in the current buffer only
	})
end

-- Create Neovim commands for the functionality
vim.api.nvim_create_user_command("SearchForLessThan", function(opts)
	search_numbers(opts.args, "less")
end, { nargs = 1 })

vim.api.nvim_create_user_command("SearchForMoreThan", function(opts)
	search_numbers(opts.args, "more")
end, { nargs = 1 })
