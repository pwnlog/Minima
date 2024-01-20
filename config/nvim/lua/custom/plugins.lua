local plugins = {
	{
		"vim-crystal/vim-crystal",
		ft = "crystal",
		config = function(_)
			vim.g.crystal_auto_format = 1
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"asm-lsp",
				"pyright",
				"rust-analyzer",
				"gopls",
			},
		},
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				-- defaults 
				"vim",
				"lua",

				-- generic
				"bash",
				"python",
				"lua",
				"perl",
				"ruby",
				"go",
				"rust",

				-- web dev 
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",

			 	-- low level
				"nasm",
				"c",
				"cpp",
				"zig"
			},
		},
	},
}

return plugins