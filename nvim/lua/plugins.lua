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
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
			
			local handlers = {
           -- The first entry (without a key) will be the default handler
           -- and will be called for each installed server that doesn't have
           -- a dedicated handler.
           function (server_name) -- default handler (optional)
               require("lspconfig")[server_name].setup {}
           end,
           -- Next, you can provide targeted overrides for specific servers.
           -- ["rust_analyzer"] = function ()
           --     require("rust-tools").setup {}
           -- end,
           -- ["lua_ls"] = function ()
           --     local lspconfig = require("lspconfig")
           --     lspconfig.lua_ls.setup {
           --         settings = {
           --             Lua = {
           --                 diagnostics = {
           --                     globals = { "vim" }
           --                 }
           --             }
           --         }
           --     }
           -- end
	   }
	   require("mason-lspconfig").setup_handlers(handlers)
   end
  }
}
