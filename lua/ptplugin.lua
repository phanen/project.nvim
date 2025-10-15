local fn, fs = vim.fn, vim.fs
local u = {
  eval = function(v, ...)
    if vim.is_callable(v) then return v(...) end
    return v
  end,
}
---START INJECT project.lua

---@class project.opts
---@field iglobs? string[]
---@field conform_ft_opts? table<string, string[]>
---@field runner? table<string, table>
local M

---@param field string project field
---@param root? string|fun():string rooter
---@return any
local get = function(field, root)
  local ok, loader =
    pcall(loadfile, fs.normalize('example/rc.lua', { _fast = true, expand_env = false }))
  if not ok then return end
  local mod = u.eval(loader)
  root = root and u.eval(root) or fs.root(0, '.git') -- a trivial fallback rooter
  local name = root and fs.basename(fn.expand(root)) or nil
  return mod and vim.tbl_get(mod, name, field) or nil
end

M = setmetatable({}, {
  __index = function(_, field) return get(field) end,
  __call = function(_, root)
    return setmetatable({}, {
      __index = function(_, field) return get(field, root) end,
    })
  end,
})

return M
