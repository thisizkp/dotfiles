local M = {}

function M.setup()
  require('neorg').setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            default = "~/notes",
            gtd = "~/notes/gtd",
            journal = "~/notes/journal"
          }
        }
      },
      ["core.norg.journal"] = {
        config = {
          workspace = 'journal',
          journal_folder = nil
        }
      },
      ["core.gtd.base"] = {
        config = {
          workspace = 'gtd',
        }
      },
      ["core.integrations.telescope"] = {}
    }
  }
end

return M
