-- Clipboard commands

vim.api.nvim_create_user_command("CopyPath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  vim.notify("Copied: " .. vim.fn.expand("%:p"), vim.log.levels.INFO)
end, { desc = "Copy file path to clipboard" })

vim.api.nvim_create_user_command("CopyContext", function(args)
  local buf = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(buf)
  local rel_path = vim.fn.fnamemodify(path, ":.")
  
  local lines
  if args.range > 0 then
    lines = string.format("%s:%d-%d", rel_path, args.line1, args.line2)
  else
    local cursor = vim.api.nvim_win_get_cursor(0)
    lines = string.format("%s:%d", rel_path, cursor[1])
  end
  
  vim.fn.setreg("+", lines)
  vim.notify("Copied: " .. lines, vim.log.levels.INFO)
end, { nargs = "*", range = "%", desc = "Copy file:line or file:line-start-end to clipboard" })
