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
            local trailspace = require('mini.trailspace')
            trailspace.setup()

            vim.api.nvim_set_hl(0, "MiniTrailspace", { bg="#db8246" })
            vim.keymap.set('n', '<leader>tr', trailspace.trim, {})
        end,
    },
}
