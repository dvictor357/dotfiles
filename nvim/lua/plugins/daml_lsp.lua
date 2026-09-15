return {
  {
    "Sengoku11/daml.nvim",
    ft = "daml",
    cmd = "DamlRunScript",
    keys = {
      { "<leader>gt", "<cmd>DamlRunScript<cr>", desc = "Run Daml Script" },
    },
    init = function()
      vim.filetype.add({ extension = { daml = "daml" } })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "saghen/blink.cmp",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "haskell" } },
  },
}
