-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- d supprime sans écraser le registre (utiliser y pour copier, p pour coller)
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete line without yanking" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without yanking" })

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  Snacks.notify.info("Copié : " .. path)
end, { desc = "Copy file path" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Toggle terminal avec le leader (Warp intercepte <C-/>)
vim.keymap.set("n", "<leader>tt", function()
  Snacks.terminal.toggle(nil, { cwd = LazyVim.root() })
end, { desc = "Toggle Terminal (Root Dir)" })

-- Masquer le terminal depuis l'intérieur (mode terminal)
vim.keymap.set("t", "<leader>tt", "<cmd>close<cr>", { desc = "Hide Terminal" })

