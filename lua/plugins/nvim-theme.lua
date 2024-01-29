-- CATPPUCCIN
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "catppuccin"
    end
}

-- TOKYONIGHT
-- return {
--     "folke/tokyonight.nvim",
--     name = "tokyonight",
--     opts = {
--         transparent = true,
--         styles = {
--             sidebars = "transparent",
--             floats = "transparent",
--         },
--     },
--     config = function()
--         vim.cmd.colorscheme "tokyonight"
--     end
-- }
