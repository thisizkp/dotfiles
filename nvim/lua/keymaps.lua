local wk = require("which-key")

wk.register({
	-- diagnostics
	["<leader>e"] = { "<cmd>vim.diagnostic.open_float<cr>", "Open Diagnostics" },
	["[d"] = { "<cmd>vim.diagnostic.goto_prev<cr>", "Prev Diagnostic" },
	["]d"] = { "<cmd>vim.diagnostic.goto_next<cr>", "Next Diagnostic" },

	-- telescope
	["<leader>f"] = {
		name = "+file",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
	}
})

-- escape to normal mode from insert mode using `jk`
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
