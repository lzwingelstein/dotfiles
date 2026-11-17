-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- disable the defult wrap and check for spell in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.spell = false
  end,
})

-- auto-reload files changed on disk (e.g. after a git rebase/checkout)
-- complements LazyVim's default checktime on FocusGained/TermClose/TermLeave
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("auto_checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" and vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- notify when a buffer is reloaded from disk
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("auto_checktime_notify", { clear = true }),
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})
