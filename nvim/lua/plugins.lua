return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

  -- File explorer
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
  }   
  
  -- Search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function() require'lspconfig'.tsserver.setup{} end
  }

  -- Formatter
  use {
    'mhartington/formatter.nvim',
    config = function()
      local prettierConfig = function()
        return {
          exe = 'prettier',
          args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
          stdin = true
        }
      end
    
      require('formatter').setup({
        filetype = {
          javascript = {prettierConfig},
          typescript = {prettierConfig},
          typescriptreact = {prettierConfig}
        }
      })
    end
  }
end)
