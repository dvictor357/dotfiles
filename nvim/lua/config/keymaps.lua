-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- stay in place after joining / yanking
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
map("v", "y", "ygv<esc>", { desc = "Yank (keep cursor)" })

-- keep search results centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- paste over selection without clobbering the register
map("x", "<leader>p", [["_dP]], { desc = "Paste (keep register)" })

-- quick escape from terminal mode
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
