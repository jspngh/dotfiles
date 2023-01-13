local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-d>', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.project, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
