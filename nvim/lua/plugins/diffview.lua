return {
  { 
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<leader>gD", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
    end
  },
}
