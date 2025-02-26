return {
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>fY",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Yazi (cwd)",
      },
      {
        -- Open in the current working directory
        "<leader>fy",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi (Root Dir)",
      },
      -- {
      --   "<leader>yy",
      --   "<cmd>Yazi toggle<cr>",
      --   desc = "Resume the last yazi session",
      -- },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
