return {
    "ThePrimeagen/harpoon",
    config = function()
        require("harpoon").setup()

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set(
            "n",
            "<leader>a",
            mark.add_file,
            { desc = "[A]dd harpoon mark." }
        )
        vim.keymap.set("n", "<C-y>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<C-j>", function()
            ui.nav_file(1)
        end)
        vim.keymap.set("n", "<C-k>", function()
            ui.nav_file(2)
        end)
        vim.keymap.set("n", "<C-l>", function()
            ui.nav_file(3)
        end)
    end,
}
