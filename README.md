Minimalist project-local config management.
* When: don't want to expose random information in `.exrc`
* When: Copy-paste lines > Copy-paste file.

```lua
-- anykey can be used as long as they are defined in example/rc.lua
require('project').custom_opts
```

e.g. shim in conform.nvim plugin:
* example/rc.lua
* example/conform.lua
