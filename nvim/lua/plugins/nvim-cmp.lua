return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    },
    lazy = false,
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end,
            },
            mapping = {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = {
                { name = 'nvim_lsp', max_item_count = 4 },
                { name = 'buffer', max_item_count = 2 },
                { name = 'vsnip', max_item_count = 2 },
            },
            completion = {
                keyword_length = 4
            }
        })

        -- Setup lspconfig.
        local nvim_lsp = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local on_attach = function(client, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>cr', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        end

        nvim_lsp["clangd"].setup({
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
            cmd = {
                "clangd",
                "-j=3",
                "--compile-commands-dir=build",
                "--background-index",
                "--clang-tidy",
                "--completion-style=detailed",
                "--header-insertion=never"
            },
            capabilities = capabilities,
            root_dir = function()
                return vim.fn.getcwd()
            end
        })

        nvim_lsp["rust_analyzer"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = true,
                    check = {
                        command = "clippy",
                        allTargets = false,
                    },
                    diagnostic = {
                        refreshSupport = false,
                    }
                }
            }
        })

        nvim_lsp["pyright"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = nvim_lsp.util.find_git_ancestor,
            flags = {
                debounce_text_changes = 150,
            }
        })
    end,
}
