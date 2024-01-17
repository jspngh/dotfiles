return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup {
            options = {
                theme = 'moonfly',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { left = '' }, right_padding = 2 },
                },
                lualine_b = { 'filename', 'branch' },
                lualine_c = { 'fileformat' },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' }
            }
        }
    end,
}

