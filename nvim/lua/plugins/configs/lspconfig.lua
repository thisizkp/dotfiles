require("nvim-lsp-installer").setup {}

local lspconfig = require("lspconfig")
local settings = {}
local runtime_path = vim.split(package.path, ';')

-- Lua
settings["sumneko_lua"] = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = runtime_path,
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
  }
}


-- Add buffer keymaps
local function on_attach()
  -- setup buffer keymaps..etc
end

for _, server in ipairs { "sumneko_lua" } do
  lspconfig[server].setup {
    on_attach = on_attach,
    settings = settings[server]
  }
end

