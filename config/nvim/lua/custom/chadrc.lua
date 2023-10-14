---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'catppuccin',
  statusline = {
    theme = "default",
    separator_style = "default",
  },
  tabufline = {
    lazyload = true,
    overriden_modules = nil,
  },
}
M.plugins = 'custom.plugins'
vim.cmd('hi Normal guibg=none ctermbg=none')

return M