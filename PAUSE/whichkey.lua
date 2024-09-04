return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup()

      -- Updated key chains with the suggested spec
      require("which-key").register({
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>p", group = "[P]roject" },
        { "<leader>p_", hidden = true },
        { "<leader>g", group = "[G]it" },
        { "<leader>g_", hidden = true },
        { "<leader>t", group = "[T]ab" },
        { "<leader>t_", hidden = true },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>h_", hidden = true },
      })

      -- Visual mode with the updated spec
      require("which-key").register({
        { "<leader>h", desc = "Git [H]unk", mode = "v" },
      })

    end,
  },
  {
    "echasnovski/mini.icons",
    version = "*",
  },
}
