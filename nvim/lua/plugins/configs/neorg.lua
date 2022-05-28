require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          default = "~/notes",
          gtd = "~/notes/gtd"
        }
      }
    },
    ["core.norg.journal"] = {},
    ["core.gtd.base"] = {
      config = {
        workspace = 'gtd',
      }
    }
  }
}
