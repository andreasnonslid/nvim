return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason").setup {}
      local util = require("lspconfig.util")
      local WORKSPACE_ROOT = vim.loop.cwd()

      local function find_cc_dir(fname)
        local path_join, dirname = util.path.join, util.path.dirname
        local function iter(dir)
          if dir == WORKSPACE_ROOT or not dir:find(WORKSPACE_ROOT, 1, true) then
            return nil
          end
          if util.path.is_file(path_join(dir, "compile_commands.json")) then
            return dir
          end
          local hits = vim.fn.glob(path_join(dir, "build", "**", "compile_commands.json"), false, true)
          if #hits > 0 then
            return dirname(hits[1])
          end
        end
        return util.search_ancestors(fname, iter)
      end

      local servers = {
        lua_ls = {},
        clangd = {
          cmd = { "clangd" },
          root_dir = function(fname)
            return find_cc_dir(fname) or WORKSPACE_ROOT
          end,
          on_new_config = function(cfg, root)
            local dir = find_cc_dir(root)
            if dir then
              table.insert(cfg.cmd, "--compile-commands-dir=" .. dir)
            end
          end,
        },
      }

      local caps = vim.lsp.protocol.make_client_capabilities()
      pcall(function()
        caps = require("blink.cmp").get_lsp_capabilities(caps)
      end)

      local mason_lsp = require("mason-lspconfig")
      mason_lsp.setup({ ensure_installed = vim.tbl_keys(servers) })

      for name, opts in pairs(servers) do
        local merged = vim.tbl_deep_extend("force", {
          capabilities = caps,
          on_attach = function(_, buf)
            local map = function(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
            end
            map("gd", vim.lsp.buf.definition, "LSP · Go to definition")
            map("gI", vim.lsp.buf.implementation, "LSP · Go to implementation")
          end,
        }, opts or {})
        require("lspconfig")[name].setup(merged)
      end
    end,
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = false } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      format_on_save = { timeout_ms = 3000, lsp_fallback = true },
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
    },
  },
}

