return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            renderer = {
                group_empty = true,
                add_trailing = true,
                icons = {
                    show = {
                        folder_arrow = false,
                    },
                },
            },
        })
    end,
}
