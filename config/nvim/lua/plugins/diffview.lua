return {
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff Open" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "Project History" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diff Close" },
    },
  },
}
