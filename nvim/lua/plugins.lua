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

  -- TreeSitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',

    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { 'rust', 'zig', 'python', 'typescript', 'javascript' }, 
        highlight = {
          enable = true
        },
      }
    end
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

  use { 
    'akinsho/toggleterm.nvim',
    
    require("toggleterm").setup{
      open_mapping = [[<c-t>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      
      float_opts = {
        border = 'single', 
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        }
      }
    }
  }
end)
