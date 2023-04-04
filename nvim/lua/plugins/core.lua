return {
	{ 
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		init = function()
		 	flavour = "latte"
		 	transparent_background = true
		 	term_colors = true
		 	integrations = {
		 		telescope = true,
		 		treesitter = true,
		 		which_key = true,
		 	}
		end,
		config = function()
			vim.cmd.colorscheme "catppuccin"
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { {'nvim-lua/plenary.nvim'} },
	},
	{ "folke/which-key.nvim", lazy = true }
}
