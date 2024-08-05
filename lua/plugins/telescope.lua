      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
return {
  'nvim-telescope/telescope.nvim',
  --branch = '0.1.x',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        color_devicons = false,
        layout_config = {
          height = 100,
          width = 1000,
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          ["no-heading"] = true,
          ["with-filename"] = true,
          ["line-number"] = true,
          ["column"] = true,
          ["smart-case"] = true,
        },
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = "delete_buffer",
            },
          },
          --ignore_current_buffer = true,
          sort_mru = true,
        }
      },
    })

    require("telescope").load_extension("lazygit")
    require('telescope').load_extension('fzf')
      local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
          vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
          vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
          vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
          vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
          vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
          vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
          vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
          vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
          vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
          --vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
          vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = '[P]roject [G]it Files'})
          -- Slightly advanced example of overriding default behavior and theme
          vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false,
            })
          end, { desc = '[/] Fuzzily search in current buffer' })
          vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files',
            }
          end, { desc = '[S]earch [/] in Open Files' })
          -- Shortcut for searching your Neovim configuration files
          vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
          end, { desc = '[S]earch [N]eovim files' })
    end,
    extensions = {
      fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
}
