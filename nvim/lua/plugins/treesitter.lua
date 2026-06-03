return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter").setup {
          ensure_installed = { "c", "lua", "rust", "json" },
          auto_install = true,
          sync_install = false,
          highlight = { enable = true },
      }
    end
}
