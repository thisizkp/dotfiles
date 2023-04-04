return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		init = function()
			options = {
			    transparency = true
			  }
		end,
		config = function()
			vim.cmd("colorscheme onelight")
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { {'nvim-lua/plenary.nvim'} },
	},
	{ "folke/which-key.nvim", lazy = true }
}
