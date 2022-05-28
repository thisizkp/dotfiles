require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
          require("plugins.configs.treesitter")
      end
    }

    use "williamboman/nvim-lsp-installer"

    use {
        "neovim/nvim-lspconfig",
        after = "nvim-lsp-installer",
        config = function()
            require("plugins.configs.lspconfig")
        end
    }

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
           require("plugins.configs.null-ls")
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })

    use {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim"
    }

    use 'folke/tokyonight.nvim'

    use {
        "nvim-neorg/neorg",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.configs.neorg")
        end
    }

    use {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
          "nvim-lua/plenary.nvim",
          "kyazdani42/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        }
    }

    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true
      },
      config = function()
          require("lualine").setup {
              options = {
                  theme = 'tokyonight'
              }
          }
      end
    }

    use {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup()
        end
    }

    -- use "Pocco81/AutoSave.nvim"

  end
)
