return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig")["unison"].setup{}
		end
	}
}
