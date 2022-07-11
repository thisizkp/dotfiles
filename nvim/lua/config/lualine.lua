local M = {}

function M.setup()
  local navic = require("nvim-navic")

  require("lualine").setup {
    options = {
      theme = 'catppuccin'
    },
    sections = {
      lualine_c = {
        { navic.get_location, cond = navic.is_available }
      }
    }
  }
end

return M
