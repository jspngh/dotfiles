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
        "echasnovski/mini.trailspace",
        version = '*',
        config = function()
            vim.api.nvim_set_hl(0, "MiniTrailspace", { bg="#853e1b" })
            require('mini.trailspace').setup()
        end,
    },
}
