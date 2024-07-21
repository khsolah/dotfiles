-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "

vim.g.autoformat = false

vim.opt.spell = true
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- vim.opt.number = true
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tabs to spaces
-- vim.wo.wrap = false -- do not wrap lines
vim.opt.autoindent = true -- auto indentation
-- vim.opt.smartindent = true
vim.opt.list = true -- show tab characters and trailing whitespace
vim.opt.title = true
vim.opt.formatoptions:remove("t") -- no auto-intent of line breaks, keep line wrap enabled
vim.opt.listchars = "tab:»\\ ,extends:›,precedes:‹,nbsp:·,trail:·" -- show tab characters and trailing whitespace

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless capital letter in search

vim.opt.swapfile = false -- do not use a swap file for the buffer
vim.opt.backup = false -- do not keep a backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- set directory where undo files are stored
vim.opt.undofile = true -- save undo history to a file

-- vim.opt.hlsearch = true
vim.opt.hlsearch = false -- do not highlight all matches on previous search pattern
vim.opt.incsearch = true -- incrementally highlight searches as you type

vim.opt.termguicolors = true -- enable true color support

-- vim.opt.scrolloff = 8 -- minimum number of lines to keep above and below the cursor
-- vim.opt.sidescrolloff = 8 --minimum number of columns to keep above and below the cursor
vim.opt.signcolumn = "yes" -- always show the sign column, to avoid text shifting when signs are displayed
vim.opt.isfname:append("@-@") -- include '@' in the set of characters considered part of a file name

vim.opt.updatetime = 50 -- Time in milliseconds to wait before triggering the plugin events after a change
--
-- vim.opt.showcmd = true
-- vim.opt.cmdheight = 1
-- vim.opt.laststatus = 2
-- -- vim.opt.shell = "fish"
-- vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
-- vim.opt.inccommand = "split"
-- vim.opt.smarttab = true
-- vim.opt.breakindent = true
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
-- vim.opt.wrap = false -- No Wrap lines
-- vim.opt.backspace = { "start", "eol", "indent" }
-- vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
-- vim.opt.wildignore:append({ "*/node_modules/*" })
-- vim.opt.splitbelow = true -- Put new windows below current
-- vim.opt.splitright = true -- Put new windows right of current
-- vim.opt.splitkeep = "cursor"
-- vim.opt.mouse = ""

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
-- vim.opt.formatoptions:append({ "r" })

-- vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
-- vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])
--
-- if vim.fn.has("nvim-0.8") == 1 then
--   vim.opt.cmdheight = 0
-- end

-- javascript formatting
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.js", "*.html", "*.css", "*.lua" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end,
})

-- return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- highlight yanked text using the 'IncSearch' highlight group for 40ms
local HighlightYank = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = HighlightYank,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- remove trailing whitespace from all lines before saving a file)
-- local CleanOnSave = vim.api.nvim_create_augroup('CleanOnSave', {})
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   group = CleanOnSave,
--   pattern = "*",
--   command = [[%s/\s\+$//e]],
-- })
