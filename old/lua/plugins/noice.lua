return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- Snacks supplies vim.ui.select override
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]              = true,
        },
      },
      presets = {
        command_palette        = true,
        long_message_to_split  = true,
        inc_rename             = false,
        lsp_doc_border         = false,
      },
    },
}
