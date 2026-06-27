return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },
}
