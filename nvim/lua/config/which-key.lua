local M = {}

function M.setup()
  local wk = require("which-key")

  local conf = {
    window = {
      border = "single",
      position = "bottom"
    }
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },

    f = {
      name = "Telescope",
      f = { "<cmd>Telescope find_files<CR>", "Find Files" },
      g = { "<cmd>Telescope live_grep<CR>", "Search" },
      b = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
      h = { "<cmd>Telescope help_tags<CR>", "Find Help Tags" },
      e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    },
  }

  wk.setup(conf)
  wk.register(mappings, opts)
end

return M
