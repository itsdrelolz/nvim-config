return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = 'Find project files' },
    { '<C-p>', function() require('telescope.builtin').git_files() end, desc = 'Find git files' },
    { '<leader>ps', function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end, desc = 'Grep for string' },
  },
}
