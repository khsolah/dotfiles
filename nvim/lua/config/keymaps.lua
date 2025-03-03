-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decreament
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set("n", "dw", "vb_d")

-- Center the screen after scrolling up/down with Ctrl-u/d
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Center the screen on the next/prev search result with n/N
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- delete without yanking
keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Paste in visual mode without yanking replaced text
keymap.set("x", "p", [["_dP]])

-- move a blocks of text up/down with K/J in visual mode
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- yank to clipboard
-- keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- yank line to clipboard
-- keymap.set("n", "<leader>Y", [["+Y]])

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
