return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.smart({
            filter = {
              cwd = true,
              buf = false,
            },
            hidden = true,
            ignore = true,
            cycle = true,
            git_untracked = true,
            matcher = {
              filename_bonus = true, -- give bonus for matching file names (last part of the path)
              -- the bonusses below, possibly require string concatenation and path normalization,
              -- so this can have a performance impact for large lists and increase memory usage
              cwd_bonus = true, -- give bonus for matching files in the cwd
              frecency = true, -- frecency bonus
              history_bonus = true, -- give more weight to chronological order
            },
            formatters = {
              file = {
                truncate = 80,
              },
            },
          })
        end,
        desc = "Find Files",
      },
      -- {
      --   "<leader>fb",
      --   function()
      --     Snacks.picker.buffers({
      --       current = false,
      --       hidden = true,
      --       win = {
      --         list = { keys = { ["dd"] = "bufdelete" } },
      --         input = {
      --           keys = {
      --             ["<c-x>"] = { "bufdelete", mode = { "i", "n", "v" } },
      --           },
      --         },
      --       },
      --     })
      --   end,
      -- },
      {
        "<leader>e",
        function()
          Snacks.picker.explorer({
            hidden = true,
            ignore = true,
            include = { "node_modules" },
          })
        end,
        desc = "Explorer Snacks (Root Dir)",
      },
      -- Manage Tasks
      {
        "<leader>tc",
        function()
          Snacks.picker.grep({
            supports_live = false,
            exclude = { "node_modules" },
            prompt = " ",
            -- pass your desired search as a static pattern
            search = "^\\s*- \\[x\\]",
            -- we enable regex so the pattern is interpreted as a regex
            regex = true,
            -- no “live grep” needed here since we have a fixed pattern
            live = false,
            -- restrict search to the current working directory
            dirs = { vim.fn.getcwd() },
            -- include files ignored by .gitignore
            args = { "--no-ignore" },
            -- Start in normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
          })
        end,
        desc = "Search completed tasks",
      },
      {
        "<leader>tt",
        function()
          Snacks.picker.grep({
            supports_live = false,
            exclude = { "node_modules" },
            prompt = " ",
            -- pass your desired search as a static pattern
            search = "^\\s*- \\[ \\]",
            -- we enable regex so the pattern is interpreted as a regex
            regex = true,
            -- no “live grep” needed here since we have a fixed pattern
            live = false,
            -- restrict search to the current working directory
            dirs = { vim.fn.getcwd() },
            -- include files ignored by .gitignore
            args = { "--no-ignore" },
            -- Start in normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
          })
        end,
        desc = "Search incompleted tasks",
      },
      -- File picker
      -- {
      --   "<leader><space>",
      --   function()
      --     Snacks.picker.files({
      --       finder = "files",
      --       format = "file",
      --       show_empty = true,
      --       supports_live = false,
      --       cycle = true,
      --       -- In case you want to override the layout for this keymap
      --       -- layout = "vscode",
      --       -- sort = { fields = { "name" } },
      --       diagnostics = true,
      --       diagnostics_open = false,
      --       git_status = true,
      --       git_status_open = false,
      --       git_untracked = true,
      --       matcher = {
      --         fuzzy = true, -- use fuzzy matching
      --         smartcase = true, -- use smartcase
      --         ignorecase = true, -- use ignorecase
      --         sort_empty = false, -- sort results when the search string is empty
      --         filename_bonus = true, -- give bonus for matching file names (last part of the path)
      --         file_pos = true, -- support patterns like `file:line:col` and `file:line`
      --         -- the bonusses below, possibly require string concatenation and path normalization,
      --         -- so this can have a performance impact for large lists and increase memory usage
      --         cwd_bonus = false, -- give bonus for matching files in the cwd
      --         frecency = true, -- frecency bonus
      --         history_bonus = true, -- give more weight to chronological order
      --       },
      --       formatters = {
      --         file = {
      --           -- filename_only = false,
      --           -- filename_first = false,
      --           truncate = 80,
      --           -- icon_width = 2,
      --         },
      --         severity = { pos = "right" },
      --         -- text = {
      --         --   ft = nil, ---@type string? filetype for highlighting
      --         -- },
      --         -- file = {
      --         --   filename_first = false, -- display filename before the file path
      --         --   truncate = 40, -- truncate the file path to (roughly) this length
      --         --   filename_only = false, -- only show the filename
      --         --   icon_width = 2, -- width of the icon (in characters)
      --         --   git_status_hl = true, -- use the git status highlight group for the filename
      --         -- },
      --         -- selected = {
      --         --   show_always = false, -- only show the selected column when there are multiple selections
      --         --   unselected = true, -- use the unselected icon for unselected items
      --         -- },
      --         -- severity = {
      --         --   icons = true, -- show severity icons
      --         --   level = true, -- show severity level
      --         --   ---@type "left"|"right"
      --         --   pos = "left", -- position of the diagnostics
      --         -- },
      --       },
      --       exclude = { ".git" },
      --       hidden = true,
      --       ignored = true,
      --       win = {
      --         input = {
      --           keys = {
      --             -- ["<Esc>"] = { "close", mode = { "n", "i" } },
      --           },
      --         },
      --       },
      --     })
      --   end,
      --   desc = "Find Files",
      -- },
    },
    ---@type snacks.Config
    opts = {
      -- Documentation for the picker
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
        -- file was always showing at the top, I needed a way to decrease its
        -- score, in frecency you could use :FrecencyDelete to delete a file
        -- from the database, here you can decrease it's score
        transform = function(item)
          if not item.file then
            return item
          end
          -- Demote the "lazyvim" keymaps file:
          if item.file:match("lazyvim/lua/config/keymaps%.lua") then
            item.score_add = (item.score_add or 0) - 30
          end
          -- Boost the "neobean" keymaps file:
          -- if item.file:match("neobean/lua/config/keymaps%.lua") then
          --   item.score_add = (item.score_add or 0) + 100
          -- end
          return item
        end,
        -- In case you want to make sure that the score manipulation above works
        -- or if you want to check the score of each file
        debug = {
          scores = false, -- show scores in the list
        },
        -- I like the "ivy" layout, so I set it as the default globaly, you can
        -- still override it in different keymaps
        layout = {
          preset = "ivy_split",
          -- When reaching the bottom of the results in the picker, I don't want
          -- it to cycle and go back to the top
          cycle = false,
        },
        layouts = {
          -- I wanted to modify the ivy layout height and preview pane width,
          -- this is the only way I was able to do it
          -- NOTE: I don't think this is the right way as I'm declaring all the
          -- other values below, if you know a better way, let me know
          --
          -- Then call this layout in the keymaps above
          -- got example from here
          -- https://github.com/folke/snacks.nvim/discussions/468
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
          -- I wanted to modify the layout width
          --
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              -- ["<Esc>"] = { "close", mode = { "n", "i" } },
              -- I'm used to scrolling like this in LazyGit
              ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
        },
      },
      -- Folke pointed me to the snacks docs
      -- https://github.com/LazyVim/LazyVim/discussions/4251#discussioncomment-11198069
      -- Here's the lazygit snak docs
      -- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
      lazygit = {
        theme = {
          selectedLineBgColor = { bg = "CursorLine" },
        },
        -- With this I make lazygit to use the entire screen, because by default there's
        -- "padding" added around the sides
        -- I asked in LazyGit, folke didn't like it xD xD xD
        -- https://github.com/folke/snacks.nvim/issues/719
        win = {
          -- -- The first option was to use the "dashboard" style, which uses a
          -- -- 0 height and width, see the styles documentation
          -- -- https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
          -- style = "dashboard",
          -- But I can also explicitly set them, which also works, what the best
          -- way is? Who knows, but it works
          width = 0,
          height = 0,
        },
      },
      notifier = {
        enabled = true,
        top_down = false, -- place notifications from top to bottom
      },
      image = {
        enabled = true,
        doc = {
          -- Personally I set this to false, I don't want to render all the
          -- images in the file, only when I hover over them
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          -- inline = true,
          -- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          -- float = true,
          -- Sets the size of the image
          -- max_width = 60,
          -- max_width = 60,
          -- max_height = 30,
          -- max_height = 30,
          -- Apparently, all the images that you preview in neovim are converted
          -- to .png and they're cached, original image remains the same, but
          -- the preview you see is a png converted version of that image
          --
          -- Where are the cached images stored?
          -- This path is found in the docs
          -- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
          -- For me returns `~/.cache/neobean/snacks/image`
          -- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
        },
      },
    },
  },
}
