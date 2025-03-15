-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    print("auto callback")
    local overseer = require("overseer")
    local cwd = vim.fn.getcwd()

    -- Define tasks based on the project directory
    local auto_tasks = {
      ["/"] = {
        { name = "lint", cmd = "yarn lint" },
      },
    }

    -- Check if there's a task for the current directory
    local tasks = auto_tasks[cwd]
    if tasks then
      for _, task in ipairs(tasks) do
        local new_task = overseer.new_task({
          name = task.name,
          cmd = task.cmd,
          cwd = cwd,
          components = { "default" },
        })
        new_task:start()
      end
    end
  end,
})
