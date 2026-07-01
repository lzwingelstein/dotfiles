return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- ferme juste le menu de complétion si visible, sinon comportement normal (sortie du mode insertion)
        ["<Esc>"] = { "hide", "fallback" },
      },
    },
  },
}
