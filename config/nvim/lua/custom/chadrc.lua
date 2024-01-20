---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "catppuccin",
	transparency = true,
	statusline = {
		theme = "vscode",
		separator_style = "arrow",

	},
}
M.plugins = 'custom.plugins'
vim.cmd('hi Normal guibg=none')

return M