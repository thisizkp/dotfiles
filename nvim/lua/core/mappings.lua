local opts = { noremap=true, silent=true }
local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
map('i', 'jk', '<esc>', opts)

-- Neotree
map('n', '<C-n>', '<cmd>:NeoTreeShowToggle<CR>', opts)

-- Fuzzy file finder: Telescope
map('n', '<leader>ff', '<cmd>:Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>:Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>:Telescope buffers<CR>', opts)
map('n', '<leader>fh', '<cmd>:Telescope help_tags<CR>', opts)

