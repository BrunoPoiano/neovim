local o = vim.opt

vim.scriptencoding = "utf-8"

-- Editor options
o.number = true             -- Print the line number in front of each line
o.relativenumber = true     -- Show the line number relative to the line with the cursor in front of each line.
o.clipboard = "unnamedplus" -- Uses the clipboard register for all operations except yank.
o.syntax = "on"             -- Syntax highlighting
o.autoindent = true         -- Copy indent from current line when starting a new line.
o.cursorline = true         -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true          -- Use spaces instead of tabs
o.shiftwidth = 2            -- Number of spaces to use for each step of (auto)indent.
o.softtabstop = 2
o.tabstop = 2               -- Number of spaces that a <Tab> in the file counts for.
o.encoding = "utf-8"        -- Character encoding used inside Vim.
o.fileencoding = "utf-8"    -- Character encoding for the file of this buffer.
o.ruler = true              -- Show the line and column number of the cursor position.
o.mouse = "a"               -- Enable mouse in all modes
o.title = true              -- Set the window title to the value of 'titlestring'
o.hidden = true             -- Buffer becomes hidden when abandoned
o.ttimeoutlen = 0           -- Time in milliseconds for key code or mapped key JKnce to complete
o.wildmenu = true           -- Enhanced command-line completion
o.showcmd = true            -- Show (partial) command in the last line of the screen
o.showmatch = true          -- Briefly jump to the matching bracket
o.inccommand = "split"      -- Show effects of substitute commands as you type
o.splitbelow = true         -- New horizontal splits appear below the current window
o.splitright = true         -- New vertical splits appear to the right of the current windowe

require("config.lazy")

local function setup_auto_pairs()
  local mappings = {
    { "{",  "{}<Left>" },
    { "(",  "()<Left>" },
    { "[",  "[]<Left>" },
    { "'",  "''<Left>" },
    { '"',  '""<Left>' },
    { "<>", "<></><Left><Left><Left>" },
  }

  for _, map in ipairs(mappings) do
    vim.api.nvim_set_keymap("i", map[1], map[2], { noremap = true, silent = true })
  end
end

setup_auto_pairs()

vim.o.clipboard = "unnamedplus"

-- reload the current file
vim.api.nvim_set_keymap('n', '<C-r>', ':e!<CR>', { noremap = true, silent = true })

-- Comment a line with Ctrl-/
vim.api.nvim_set_keymap('n', '<C-\\>', ':lua CommentToggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-\\>', ':lua CommentToggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-\\>', '<Esc>:lua CommentToggle()<CR>a', { noremap = true, silent = true })

-- Function to toggle comment.
function CommentToggle()
  local line = vim.fn.getline('.')
  if line:match("^%s*//") then
    vim.cmd([[execute "normal ^xx"]])
  else
    vim.cmd([[execute "normal I//"]])
  end
end

vim.api.nvim_set_keymap('v', '<C-_>', ':lua CommentToggleVisual()<CR>', { noremap = true, silent = true })

function CommentToggleVisual()
  vim.cmd([[ '<,'>s/^\(\s*\)\(\/\/\)\?/\1\=empty(\2)?"\/\/":""/ ]])
end

-- Map Ctrl-u to undo
vim.api.nvim_set_keymap("n", "<C-u>", "u", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.py", "*.c", "*.cpp", "*.tsx", "*.jsx", "*.php" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

local function set_tab_name()
  local tabname
  vim.opt_local.title = true
  vim.opt.titlestring = tabname
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = set_tab_name,
})

local function search_in_files(search_term)
  -- Check if search_term is provided
  if not search_term or search_term == "" then
    print("No search term provided.")
    return
  end

  -- Construct the ripgrep command to exclude specific directories
  local command = string.format("rg --vimgrep --glob '!node_modules/*' --glob '!.*' --glob '!.next/*' -e '%s' .",
    search_term)

  -- Capture the output of the command
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  -- Check if result is not empty
  if result ~= "" then
    -- Split the output into lines and format for quickfix
    local items = {}
    for line in result:gmatch("[^\r\n]+") do
      local filename = line:match("([^:]+)")
      local lnum = tonumber(line:match(":(%d+):"))
      if filename and lnum then
        table.insert(items, { filename = filename, lnum = lnum, text = line })
      end
    end

    -- Populate the quickfix list
    vim.fn.setqflist({}, 'r', { title = 'Search Results', items = items })
    vim.cmd("copen") -- Open the quickfix window
  else
    print("No matches found.")
  end
end

-- Create a command to search
vim.api.nvim_create_user_command('Search', function(opts)
  search_in_files(opts.args)
end, { nargs = 1 })


vim.api.nvim_create_user_command('Search', function(opts)
  search_in_files(opts.args)
end, { nargs = 1 })

--Change scroll page
vim.api.nvim_set_keymap('n', '<PageUp>', '<C-u>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<PageDown>', '<C-d>zz', { noremap = true, silent = true })

-- Tab navigations
vim.api.nvim_set_keymap("n", "gt", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gT", ":tabprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })

vim.api.nvim_set_keymap("x", "<C-j>", ":move '>+1<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-k>", ":move '<-2<CR>gv", { noremap = true, silent = true })

-- split screen
vim.api.nvim_set_keymap("n", "<C-a>", ":vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":split<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-z>", ":close<CR>", { noremap = true, silent = true })

-- Navigate between splits using Space + Arrow Keys
vim.api.nvim_set_keymap('n', '<leader><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Right>', '<C-w>l', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })

-- Binds to delete/change/replace without yanking.dd
vim.api.nvim_set_keymap('x', '<leader>p', '"_dP<CR>', {}) -- Replace without yanking
vim.api.nvim_set_keymap('x', '<leader>d', '"_d<CR>', {})  -- Delete without yanking
vim.api.nvim_set_keymap('n', '<leader>d', '"_d<CR>', {})  -- Delete without yanking
