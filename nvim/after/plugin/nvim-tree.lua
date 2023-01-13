require('nvim-tree').setup({
	disable_netrw       = true,
	hijack_netrw        = true,
	open_on_setup       = false,
	open_on_tab         = false,
	hijack_cursor       = false,
	update_cwd          = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
	update_focused_file = {
		enable      = false,
		update_cwd  = false,
		ignore_list = {}
	},
	system_open = {
		cmd  = nil,
		args = {}
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		side = 'left',
		mappings = {
			custom_only = false,
			list = {}
		}
	},
})

vim.keymap.set("n", "<leader>,", "<cmd>NvimTreeToggle<CR>zz")
