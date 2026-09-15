-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- window title (ghostty / herdr tab name)
opt.title = true
opt.titlestring = "nvim | %{fnamemodify(getcwd(), ':t')}"
opt.titlelen = 0

-- one global statusline, no per-window clutter
opt.laststatus = 3
opt.cmdheight = 1
opt.showmode = false
opt.ruler = false

-- quiet gutter
opt.signcolumn = "yes"
opt.numberwidth = 3
opt.cursorline = true
opt.cursorlineopt = "number" -- highlight only the line number, not the whole row

-- no ~ after EOF, thin separators, minimal fold/diff glyphs
opt.fillchars = {
  eob = " ",
  vert = "│",
  horiz = "─",
  fold = " ",
  foldopen = "-",
  foldclose = "+",
  foldsep = " ",
  diff = "╱",
}
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
opt.list = true

-- scrolling / editing feel
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 10
opt.pumblend = 0
opt.winblend = 0
opt.wrap = false
opt.linebreak = true

-- no animations anywhere (snacks scroll/indent/notifier, etc.)
vim.g.snacks_animate = false

vim.g.lazyvim_picker = "snacks"
