-- Markdown Helpers File

-- Toggle a checkbox on the current line
local function toggle_checkbox()
    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_get_current_line()

    if line:match("%- %[ %]") then
        line = line:gsub("%- %[ %]", "- [x]", 1)
    elseif line:match("%- %[x%]") then
        line = line:gsub("%- %[x%]", "- [ ]", 1)
    else
        print("No checkbox found on the current line.")
        return
    end

    vim.api.nvim_set_current_line(line)
end

-- Add a new checkbox below the current line
local function add_checkbox()
    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, line_nr, line_nr, false, { "- [ ] " })
    vim.api.nvim_win_set_cursor(0, { line_nr + 1, 5 })
end

-- Indent the current line
local function indent_line()
    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_buf_set_lines(0, line_nr - 1, line_nr, false, { "  " .. line })
end

-- Dedent the current line
local function dedent_line()
    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_get_current_line()
    local dedented_line = line:gsub("^%s%s", "")
    vim.api.nvim_buf_set_lines(
        0,
        line_nr - 1,
        line_nr,
        false,
        { dedented_line }
    )
end

-- Set keymaps for Markdown helpers
local function set_keymaps()
    vim.api.nvim_set_keymap(
        "n",
        "<CR>",
        ":lua require('markdown-helpers').toggle_checkbox()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "o",
        ":lua require('markdown-helpers').add_checkbox()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Tab>",
        ":lua require('markdown-helpers').indent_line()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<S-Tab>",
        ":lua require('markdown-helpers').dedent_line()<CR>",
        { noremap = true, silent = true }
    )
end

-- Automatically set keymaps when editing Markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        set_keymaps()
    end,
})

return {
    toggle_checkbox = toggle_checkbox,
    add_checkbox = add_checkbox,
    indent_line = indent_line,
    dedent_line = dedent_line,
}
