local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

-- telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', default_opts)
