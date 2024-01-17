return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        require('gitsigns').setup({
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Actions
            map('n', '<leader>hb', function() gs.blame_line{full=true} end)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hR', gs.reset_hunk)
          end
        })
    end,
}
