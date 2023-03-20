return {
	{ 
		"unisonweb/unison",
		branch = "trunk",
		ft = "u",
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/editor-support/vim")
			require("lazy.core.loader").packadd(plugin.dir .. "/editor-support/vim")
		end,
		init = function(plugin)
			require("lazy.core.loader").ftdetect(plugin.dir .. "/editor-support/vim")
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig")["unison"].setup{}
		end
	}
}
