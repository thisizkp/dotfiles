vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]

require("nvim-tree").setup {}

require("lualine").setup {
    options = {
        theme = 'tokyonight'
    }
}

require('neoscroll').setup()

require('nvim_comment').setup()
