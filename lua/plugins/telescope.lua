return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})

      vim.api.nvim_set_keymap('n', '<C-CR>', ':tab split | Telescope find_files<CR>',
        { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {                                    -- Insert mode mappings
              ["<C-d>"] = actions.select_horizontal, -- Open in horizontal split
              ["<C-a>"] = actions.select_vertical,   -- Open in vertical split
            },
            n = {                                    -- Normal mode mappings
              ["<C-d>"] = actions.select_horizontal,
              ["<C-a>"] = actions.select_vertical,
            },
          },
        },
      })
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}
