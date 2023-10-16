-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
		  'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week
  }

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Colors
  use('rebelot/kanagawa.nvim')
  use('nyoom-engineering/oxocarbon.nvim')
  use('navarasu/onedark.nvim')
  use('marko-cerovac/material.nvim')
  use {
      'rose-pine/neovim',
      as = 'rose-pine',
  }
  use {
      'bluz71/vim-moonfly-colors',
      as = 'moonfly'
  }

  -- IDE
  use('nvim-treesitter/nvim-treesitter')
  use('nvim-treesitter/playground')

  use('neovim/nvim-lspconfig')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-vsnip')
  use('hrsh7th/vim-vsnip')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')

  use('lewis6991/gitsigns.nvim')

  -- GUI enhancements
  use('machakann/vim-highlightedyank')
  use('ntpeters/vim-better-whitespace')
  use {
      'romgrk/barbar.nvim',
      wants = 'nvim-web-devicons'
  }

end)
