return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({})
      vim.keymap.set("n", "<leader>gD", ":DiffviewOpen<CR>", { desc = "Open Diffview" })

      local function pick_branch(prompt, callback)
        local branches = {}
        for _, line in ipairs(vim.fn.systemlist("git branch -a")) do
          local b = line:gsub("^[%*%+]?%s+", ""):gsub("%s+->.*", ""):gsub("%s+$", "")
          if b ~= "" then
            table.insert(branches, { text = b })
          end
        end
        Snacks.picker.pick({
          title = prompt,
          layout = "select",
          items = branches,
          format = function(item) return { { item.text } } end,
          confirm = function(picker, item)
            picker:close()
            if item then callback(item.text) end
          end,
        })
      end

      -- PR diff: current HEAD vs picked base branch
      vim.keymap.set("n", "<leader>gP", function()
        pick_branch("Base branch", function(base)
          local head = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%s+", "")
          vim.cmd("DiffviewOpen " .. base .. "..." .. head)
        end)
      end, { desc = "PR diff: current HEAD vs base branch" })

      -- PR diff: pick both base and head branches
      vim.keymap.set("n", "<leader>gp", function()
        pick_branch("Base branch", function(base)
          pick_branch("Head branch", function(head)
            vim.cmd("DiffviewOpen " .. base .. "..." .. head)
          end)
        end)
      end, { desc = "PR diff: pick both branches" })
    end,
  },
}
