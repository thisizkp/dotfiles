local wk = require("which-key")

wk.register({
	-- telescope
	["<leader>f"] = {
		name = "+file",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
	}
})

-- escape to normal mode from insert mode using `jk`
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
