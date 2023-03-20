return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd[[colorscheme nightfox]]
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { {'nvim-lua/plenary.nvim'} },
	},
	{
		"folke/which-key.nvim", lazy = true
	}
}
