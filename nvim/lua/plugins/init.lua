return {
    -- colorscheme
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme
            require("onedark").setup({
                style = "darker"
            })
            vim.cmd([[colorscheme onedark]])
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig"
    },

    -- GUI enhancements
    {
        "machakann/vim-highlightedyank"
    },
    {
        "ntpeters/vim-better-whitespace"
    },
}
