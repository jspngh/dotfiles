return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "lua", "rust", "json", "markdown" },
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })
    end
}
