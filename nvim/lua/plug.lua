require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }

    use {
      "williamboman/nvim-lsp-installer",
      {
        "neovim/nvim-lspconfig"
      }
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim"
    }

    use 'folke/tokyonight.nvim'

    use {
        "nvim-neorg/neorg",
        requires = "nvim-lua/plenary.nvim"
    }

    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons"
      },
      tag = "nightly"
    }

    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true
      }
    }

    use 'karb94/neoscroll.nvim'

    use "terrortylor/nvim-comment"

  end
)
