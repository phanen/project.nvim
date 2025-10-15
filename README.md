Minimalist project-local config management.
* When: don't want to expose random information in `.exrc`
* When: Copy-paste lines > Copy-paste file.

```lua
-- anykey can be used as long as they are defined in example/rc.lua
require('project').custom_opts
```

e.g. shim in conform.nvim plugin:
```lua
-- work without patch after https://github.com/stevearc/conform.nvim/commit/d5138205
opts = {
  default_format_opts = { lsp_format = 'fallback', timeout_ms = 10000, async = true },
  formatters_by_ft = { -- handle project-local config
    ['*'] = function(buf)
      local opts = require('project').conform_ft_opts or {}
      local ft = vim.bo[buf].ft
      local for_ft = #ft > 0 and (opts[ft] or ft_opts[ft]) or {}
      local for_all = opts['*'] or ft_opts['*'] or {}
      local ret = list_merge(for_ft, for_all)
      local has_config = #ret ~= 0
      local has_lsp = #lsp.get_clients({ bufnr = 0, method = 'textDocument/formatting' }) > 0
      return (has_config or has_lsp) and ret or { 'trim_whitespace' } -- i.e. `_` formater
    end,
  },
}
```
