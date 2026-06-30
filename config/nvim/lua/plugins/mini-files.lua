vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    vim.keymap.set("n", "?", function()
      require("which-key").show({ global = false })
    end, { buffer = args.data.buf_id, desc = "Show buffer-local keymaps" })
  end,
})

return {
  "echasnovski/mini.files",
  opts = {
    mappings = {
      go_in_plus = "l",
    },
  },
}
