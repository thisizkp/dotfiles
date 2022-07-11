local M = {}

function M.setup()
  local catppuccin = require("catppuccin")
  local settings = {
    transparent_background = false,
    term_colors = true,
    styles = {
      comments = "italic",
      conditionals = "italic",
      loops = "NONE",
      functions = "NONE",
      keywords = "NONE",
      strings = "NONE",
      variables = "NONE",
      numbers = "NONE",
      booleans = "NONE",
      properties = "NONE",
      types = "NONE",
      operators = "NONE",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "italic",
          hints = "italic",
          warnings = "italic",
          information = "italic",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        },
      },
      cmp = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = false,
      },
      which_key = true,
      neogit = true,
    }
  }

  catppuccin.setup(settings)
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
  vim.cmd[[colorscheme catppuccin]]
end

return M
