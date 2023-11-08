-- set leader to <Space>
vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options
vim.opt.number = true
vim.opt.relativenumber = true

-- indent
vim.opt.tabstop = 4	-- number of spaces a tab character will occupy
vim.opt.shiftwidth = 4	-- number of spaces used while indentation 
vim.opt.softtabstop = 4	-- number of spaces when editing text
vim.opt.smarttab = true	-- enhances the behaviour of tab key based on context

-- background
vim.opt.background = "light"

-- keymappings
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

-- package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
