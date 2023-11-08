return {
	{ 
		"ellisonleao/gruvbox.nvim", 
		priority = 1000 , 
		config = function()
			require('gruvbox').setup()
			vim.cmd('colorscheme gruvbox')
		end 
	},
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require('Comment').setup()
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		end
	},
{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
		view = {
			width = 30
		}
	})
  end,
},
	"github/copilot.vim",
}
