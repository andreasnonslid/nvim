-- Function to add safe directories only if they aren't cached
local function set_safe_git_directories()
	local lazy_path = vim.fn.stdpath("data") .. "/lazy"
	local cache_file = lazy_path .. "/.safe_git_dirs_cache"
	local directories = vim.fn.globpath(lazy_path, "*", 0, 1)

	-- Check if the cache file exists
	local cache = {}
	if vim.fn.filereadable(cache_file) == 1 then
		for line in io.lines(cache_file) do
			table.insert(cache, line)
		end
	end

	local new_cache = {}
	local needs_update = false

	-- Iterate over each directory and check if it's already cached
	for _, dir in ipairs(directories) do
		local is_cached = false
		for _, cached_dir in ipairs(cache) do
			if cached_dir == dir then
				is_cached = true
				break
			end
		end

		-- If the directory is not cached, mark it as safe and add to the new cache
		if not is_cached then
			local handle = io.popen('git config --get-all safe.directory "' .. dir .. '"')
			local result = handle:read("*a")
			handle:close()

			if result == "" then
				local git_safe_cmd = string.format('!git config --global --add safe.directory "%s"', dir)
				vim.cmd(git_safe_cmd)
				needs_update = true
			end
		end

		-- Add the directory to the new cache
		table.insert(new_cache, dir)
	end

	-- If there are new directories, write the updated cache
	if needs_update then
		local cache_handle = io.open(cache_file, "w")
		for _, cached_dir in ipairs(new_cache) do
			cache_handle:write(cached_dir .. "\n")
		end
		cache_handle:close()
	end
end

-- Set the directories as safe only when necessary
set_safe_git_directories()
