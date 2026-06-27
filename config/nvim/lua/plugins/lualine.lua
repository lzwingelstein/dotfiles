return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons

    -- Remove pretty_path from the statusline, keep the rest
    opts.sections.lualine_c = {
      LazyVim.lualine.root_dir(),
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
    }

    -- Show the file path breadcrumb in the winbar (top of each window)
    opts.winbar = {
      lualine_c = { LazyVim.lualine.pretty_path() },
    }
    opts.inactive_winbar = {
      lualine_c = { LazyVim.lualine.pretty_path() },
    }
  end,
}
