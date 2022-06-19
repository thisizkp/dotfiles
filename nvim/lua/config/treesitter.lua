local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "norg", "javascript", "lua", "python", "rust", "typescript" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end

return M
