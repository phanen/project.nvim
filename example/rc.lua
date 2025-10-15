---@class project.opts
local M = {}

M['flatpak'] = {
  conform_ft_opts = { c = { 'uncrustify' }, h = { 'uncrustify' } },
  iglobs = { '*.po' },
}

M['miniflux-v2'] = {
  iglobs = { 'internal/locale/translations/' },
}

return M
