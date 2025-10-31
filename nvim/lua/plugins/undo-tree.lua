return {
  {
    "mbbill/undotree",
    init = function()
      -- Layout 選項：1 左側, 2 右側（預設）, 3 水平, 4 只顯示 undotree
      vim.g.undotree_WindowLayout = 2

      -- 是否自動開啟 diff 視窗
      -- vim.g.undotree_DiffAutoOpen = 1

      -- undotree 視窗寬度
      -- vim.g.undotree_SplitWidth = 40

      -- 開啟時自動 focus 到 undotree 視窗
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
    config = function()
      vim.keymap.set("n", "<leader>cu", ":UndotreeToggle<CR>", { desc = "Toggle Undotree" })
    end,
  },
}
