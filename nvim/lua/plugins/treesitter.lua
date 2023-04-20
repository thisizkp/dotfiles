return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false
			},
			ensure_installed = { "lua", "python", "typescript", "vim", "zig" },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
