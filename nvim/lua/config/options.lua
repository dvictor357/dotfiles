-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Report terminal/tab title as: nvim | project_name (cwd basename)
vim.opt.title = true
vim.opt.titlestring = "nvim | %{fnamemodify(getcwd(), ':t')}"
vim.opt.titlelen = 0
