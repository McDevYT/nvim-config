return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
		local telescope = require('telescope')
		telescope.load_extension('fzf')

		local keymap = vim.keymap

		keymap.set('n', '<leader>fd', ':Telescope find_files<cr>')
		keymap.set('n', '<leader>fs', ':Telescope live_grep<cr>')
		keymap.set('n', '<leader>fg', ':Telescope git_files<cr>')
		keymap.set('n', '<leader>fd', ':Telescope find_files<cr>')
		keymap.set('n', '<leader>fc', ':Telescope grep_string<cr>')
		keymap.set('n', '<leader>fl', ':Telescope lsp_document_symbols<cr>')
		keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')

		keymap.set('n', '<leader>fn', function()
			require('telescope.builtin').find_files({
				cwd = vim.fn.stdpath('config')
			})
		end)
	end
	
}
