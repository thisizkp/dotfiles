local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local is_dark = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):match("Dark") ~= nil

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

local function focus_lsp_hover()
  local hover_win = vim.b.lsp_floating_preview

  if hover_win and vim.api.nvim_win_is_valid(hover_win) then
    vim.wo[hover_win].concealcursor = "n"
    vim.api.nvim_set_current_win(hover_win)
    vim.cmd("stopinsert")
    return true
  end

  return false
end

local function hover_and_focus()
  vim.lsp.buf.hover({
    border = "rounded",
    focusable = true,
    max_width = math.floor(vim.o.columns * 0.75),
    max_height = math.floor(vim.o.lines * 0.6),
  })

  local attempts = 0
  local function try_focus()
    attempts = attempts + 1

    if focus_lsp_hover() or attempts >= 30 then
      return
    end

    vim.defer_fn(function()
      try_focus()
    end, 10)
  end

  try_focus()
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = function(desc)
      return { buffer = event.buf, desc = desc }
    end

    vim.keymap.set("n", "K", hover_and_focus, opts("Show hover documentation"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Show references"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
  end,
})

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")

require("lazy").setup({
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = is_dark and "dark" or "light",
      transparent = true,
      term_colors = false,
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },
})
