-- set leader to <Space>
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options
vim.opt.number = true
vim.opt.relativenumber = true

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
require("keymaps")

-- theme
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd[[hi normal guibg=NONE ctermbg=NONE]]
