return {
    "nvim-treesitter/nvim-treesitter",
    version = "0.9.1",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "rust" },
          sync_install = false,
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
}
