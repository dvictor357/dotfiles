-- void UI: one statusline, no tab bar, no floating cmdline, no animations
local void = {
  bg = "#0a0a0a",
  bg1 = "#161616",
  bg2 = "#262626",
  dim = "#4a4a4a",
  mute = "#8a8a8a",
  fg = "#c9c9c9",
  bright = "#ededed",
  green = "#5fb56a",
  amber = "#c9a85c",
  red = "#cf5c5c",
  blue = "#6b8fb5",
  purple = "#a98cc4",
}

return {
  -- herdr/tmux already give us tabs; drop the buffer tab bar
  { "akinsho/bufferline.nvim", enabled = false },

  -- classic bottom cmdline instead of a popup in the middle of the screen
  { "folke/noice.nvim", enabled = false },

  -- LazyVim installs catppuccin by default; we only use tokyonight (recolored)
  { "catppuccin/nvim", enabled = false },

  -- statusline: mode dot · file · branch · diagnostics · position
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local mode_color = {
        n = void.green,
        i = void.blue,
        v = void.purple,
        V = void.purple,
        ["\22"] = void.purple,
        c = void.amber,
        R = void.red,
        t = void.amber,
      }
      local function mode_dot()
        return "●"
      end
      local function mode_hl()
        return { fg = mode_color[vim.fn.mode()] or void.dim }
      end

      local flat = { a = { bg = "NONE", fg = void.fg }, b = { bg = "NONE", fg = void.mute }, c = { bg = "NONE", fg = void.dim } }
      local theme = { normal = flat, insert = flat, visual = flat, replace = flat, command = flat, terminal = flat, inactive = flat }

      return {
        options = {
          theme = theme,
          globalstatus = true,
          component_separators = "",
          section_separators = "",
          disabled_filetypes = { statusline = { "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { { mode_dot, color = mode_hl, padding = { left = 1, right = 1 } } },
          lualine_b = {
            { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "" }, color = { fg = void.fg } },
          },
          lualine_c = {
            { "branch", icon = "", color = { fg = void.dim } },
            {
              "diagnostics",
              symbols = { error = "E", warn = "W", info = "I", hint = "H" },
              diagnostics_color = {
                error = { fg = void.red },
                warn = { fg = void.amber },
                info = { fg = void.blue },
                hint = { fg = void.dim },
              },
              padding = { left = 1 },
            },
          },
          lualine_x = {
            { "searchcount", color = { fg = void.dim } },
            { "filetype", icons_enabled = false, color = { fg = void.dim } },
          },
          lualine_y = {},
          lualine_z = { { "location", color = { fg = void.mute }, padding = { left = 1, right = 1 } } },
        },
        inactive_sections = {},
        extensions = { "lazy", "trouble" },
      }
    end,
  },

  -- snacks: bare dashboard, no scroll animation, thin indent guides
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = {
        indent = { char = "│", hl = "SnacksIndent" },
        scope = { char = "│", hl = "SnacksIndentScope", underline = false },
        animate = { enabled = false },
      },
      notifier = { style = "minimal", top_down = false, timeout = 2500 },
      dashboard = {
        width = 40,
        preset = {
          header = "void",
          keys = {
            { icon = "", key = "f", desc = "files", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "", key = "r", desc = "recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "", key = "g", desc = "grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "", key = "s", desc = "session", section = "session" },
            { icon = "", key = "l", desc = "lazy", action = ":Lazy" },
            { icon = "", key = "q", desc = "quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header", padding = 1 },
          { section = "keys", gap = 0, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },

  -- which-key: no border, no icons
  {
    "folke/which-key.nvim",
    opts = { preset = "helix", icons = { mappings = false } },
  },

  -- treesitter: skip highlighting on huge files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = function(_, buf)
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > 1024 * 1024
        end,
      },
    },
  },
}
