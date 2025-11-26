return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- themes
  use 'EdenEast/nightfox.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "ellisonleao/gruvbox.nvim" }
  use { 'folke/tokyonight.nvim' }
  use { 'marko-cerovac/material.nvim' }
  use { 'sainnhe/gruvbox-material' }
  use { 'Mofiqul/dracula.nvim' }

  -- LSP
  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.skip_server_setup({'ruby'})
      lsp.preset("recommended")
      lsp.setup()
      lsp.nvim_workspace()
    end,
  })

end)
