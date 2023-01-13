local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<left>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<right>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<C-left>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<C-right>', '<Cmd>BufferMoveNext<CR>', opts)

vim.keymap.set('n', '<leader>bd', '<Cmd>BufferDelete<CR>', {})
