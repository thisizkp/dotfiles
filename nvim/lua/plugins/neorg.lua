return {
	{
		"nvim-neorg/neorg",
		ft = "norg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.norg.concealer"] = {
					config = {
						icons = {
							todo = {
								enabled = true,
								cancelled = { icon = '✗' },
								done = { icon = '✔️' },
							}
						}
					}
				},
				["core.norg.dirman"] = {
					config = {
						workspaces = {
							default = "~/notes",
							notes = "~/notes",
							work = "~/work",
						}
					}
				}
			}
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	}
}
