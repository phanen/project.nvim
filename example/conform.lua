---@diagnostic disable
-- work without patch after https://github.com/stevearc/conform.nvim/commit/d5138205
return {
  default_format_opts = { lsp_format = 'fallback', timeout_ms = 10000, async = true },
  formatters_by_ft = { -- handle project-local config
    ['*'] = function(buf)
      local opts = require('project').conform_ft_opts or {}
      local ft = vim.bo[buf].ft
      local for_ft = #ft > 0 and (opts[ft] or ft_opts[ft]) or {}
      local for_all = eval(opts['*'] or ft_opts['*'], buf) or {}
      local ret = list_merge(for_ft, for_all)
      local has_config = #ret ~= 0
      local has_lsp = #lsp.get_clients({ bufnr = 0, method = 'textDocument/formatting' }) > 0
      return (has_config or has_lsp) and ret or { 'trim_whitespace' } -- i.e. `_` formater
    end,
  },
}
