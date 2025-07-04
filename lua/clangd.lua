-- ~/.config/nvim/lua/clangd.lua
local lsp, util = require('lspconfig'), require('lspconfig.util')

---------------------------------------------------------------------------
-- 1 · search for compile_commands.json
---------------------------------------------------------------------------
local function db_dir(start_file)
  local function has(file) return vim.fn.filereadable(file) == 1 end
  local dir = vim.fs.dirname(start_file)

  -- walk upward to the filesystem root
  while dir and dir ~= '' do
    -- 1a · exact file in this dir
    if has(util.path.join(dir, 'compile_commands.json')) then
      return dir
    end
    -- 1b · first hit under build/** in this dir
    local hits = vim.fn.glob(
                   util.path.join(dir, 'build', '**', 'compile_commands.json'),
                   false, true)
    if #hits > 0 then
      return util.path.dirname(hits[1])
    end
    -- ascend one level
    dir = vim.fs.dirname(dir)
  end
end

---------------------------------------------------------------------------
-- 2 · buffer-local key-maps when clangd attaches
---------------------------------------------------------------------------
local function on_attach(_, buf)
  local opts = {buffer = buf, silent = true}
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition,     opts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
end

---------------------------------------------------------------------------
-- 3 · optional blink.cmp capabilities (ignored if blink missing)
---------------------------------------------------------------------------
local caps = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  caps = require('blink.cmp').get_lsp_capabilities(caps)
end)

---------------------------------------------------------------------------
-- 4 · launch clangd only when database exists
---------------------------------------------------------------------------
lsp.clangd.setup{
  cmd          = {'clangd'},
  capabilities = caps,
  on_attach    = on_attach,

  root_dir = function(fname)           -- nil → clangd stays off
    return db_dir(fname)
  end,

  on_new_config = function(cfg, root)  -- tell clangd where the DB lives
    local dir = db_dir(root)
    if dir then
      table.insert(cfg.cmd, '--compile-commands-dir=' .. dir)
    end
  end,
}

