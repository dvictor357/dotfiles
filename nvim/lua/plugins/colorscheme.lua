-- void: tokyonight-night skeleton, recolored to match the terminal palette
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = false, -- inherit ghostty's palette in :terminal
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(c)
        c.bg = "#0a0a0a"
        c.bg_dark = "#0a0a0a"
        c.bg_float = "#0a0a0a"
        c.bg_sidebar = "#0a0a0a"
        c.bg_statusline = "#0a0a0a"
        c.bg_highlight = "#161616"
        c.bg_visual = "#262626"
        c.fg = "#c9c9c9"
        c.fg_dark = "#a0a0a0"
        c.fg_gutter = "#303030"
        c.comment = "#4a4a4a"
        c.border = "#262626"
        c.border_highlight = "#4a4a4a"
        c.green = "#5fb56a"
        c.green1 = "#7ccbbf"
        c.red = "#cf5c5c"
        c.yellow = "#c9a85c"
        c.blue = "#82a5cc"
        c.cyan = "#5fb5a8"
        c.magenta = "#a98cc4"
        c.purple = "#a98cc4"
        c.orange = "#dbbf75"
      end,
      on_highlights = function(hl, c)
        hl.LineNr = { fg = "#303030" }
        hl.CursorLineNr = { fg = "#5fb56a", bold = true }
        hl.CursorLine = { bg = "#101010" }
        hl.WinSeparator = { fg = "#262626" }
        hl.FloatBorder = { fg = "#262626", bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.Pmenu = { bg = "#101010", fg = "#c9c9c9" }
        hl.PmenuSel = { bg = "#262626", fg = "#ededed", bold = true }
        hl.Visual = { bg = "#262626" }
        hl.Search = { bg = "#262626", fg = "#5fb56a" }
        hl.IncSearch = { bg = "#5fb56a", fg = "#0a0a0a" }
        hl.MatchParen = { fg = "#5fb56a", bold = true, underline = true }
        hl.NonText = { fg = "#262626" }
        hl.Whitespace = { fg = "#262626" }
        hl.StatusLine = { bg = "NONE", fg = "#c9c9c9" }
        hl.StatusLineNC = { bg = "NONE", fg = "#4a4a4a" }
        hl.SnacksIndent = { fg = "#161616" }
        hl.SnacksIndentScope = { fg = "#303030" }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight-night" },
  },
}
