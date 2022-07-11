local M = {}

function M.setup()
  -- indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost */nvim/lua/plugins.lua source <afile> | PackerCompile"
  end

  -- plugins
  local function plugins(use)
    -- packer
    use 'wbthomason/packer.nvim'

    -- load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- theme
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("config.catppuccin").setup()
      end
    }

    -- treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end
    }

    -- lsp
    use {
      "neovim/nvim-lspconfig",
      wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim" },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim",
      }
    }

    -- completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      disable = false,
    }

    -- git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

    -- fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim"
    }

    -- note taking, gtd, org-mode
    use {
      "nvim-neorg/neorg",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope"
      },
      config = function()
        require("config.neorg").setup()
      end
    }

    -- keybindings
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.which-key").setup()
      end
    }

    -- comment
    use 'b3nj5m1n/kommentary'

    -- status line
    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true
      },
      config = function()
        require("config.lualine").setup()
      end
    }

    -- current code context
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }

    -- file explorer
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("nvim-tree").setup()
      end,
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
