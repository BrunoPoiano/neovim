local global = vim.g
local o = vim.opt

vim.scriptencoding = "utf-8"

-- Map <leader>
global.mapleader = " "
global.maplocalleader = " "

-- Editor options
o.number = true             -- Print the line number in front of each line
o.relativenumber = false    -- Show the line number relative to the line with the cursor in front of each line.
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
o.splitright = true         -- New vertical splits appear to the right of the current window

require("config.lazy")


local function setup_auto_pairs()
  local mappings = {
    { '{',  '{}<Left>' },
    { '(',  '()<Left>' },
    { '[',  '[]<Left>' },
    { "'",  "''<Left>" },
    { '"',  '""<Left>' },
    { '<>', '<></><Left><Left><Left>' },
  }

  for _, map in ipairs(mappings) do
    vim.api.nvim_set_keymap('i', map[1], map[2], { noremap = true, silent = true })
  end
end

setup_auto_pairs()

vim.o.clipboard = "unnamedplus"

-- Map Ctrl-u to undo
vim.api.nvim_set_keymap("n", "<C-u>", "u", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.py", "*.c", "*.cpp", "*.tsx", "*.jsx" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.api.nvim_set_keymap("n", "gt", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gT", ":tabprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<S-k>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-j>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", "dd", { noremap = true, silent = true })
