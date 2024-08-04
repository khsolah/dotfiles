return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<leader>fp",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume previous picker",
      },
      {
        "<leader>fo",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "<leader>fm",
        function()
          local extensions = require("telescope").extensions
          extensions.media_files.media_files()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg", "gif" },
            -- find command (defaults to `fd`)
            -- find_cmd = "rg",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        layout_config = {},
      })

      telescope.load_extension("media_files")
      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
