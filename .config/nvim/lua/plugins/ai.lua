return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        condition = function()
          return vim.bo.filetype ~= "typr"
        end,
      })
    end,
  },
}
