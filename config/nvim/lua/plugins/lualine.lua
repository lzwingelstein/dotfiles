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

    -- Colore l'horloge selon le workspace (cwd) ouvert
    opts.sections.lualine_z = {
      {
        function()
          return " " .. os.date("%R")
        end,
        color = function()
          local cwd = vim.fn.getcwd()
          local workspace_colors = {
            { path = vim.fn.expand("~/work/notes"), color = "#a6e3a1" }, -- vert
            { path = vim.fn.expand("~/work/console"), color = "#f5c2e7" }, -- rose
            { path = vim.fn.expand("~/work/console-quickfix-01"), color = "#f38ba8" }, -- rouge
            { path = vim.fn.expand("~/work/terraform-console"), color = "#89dceb" }, -- cyan
          }
          for _, ws in ipairs(workspace_colors) do
            if cwd == ws.path or vim.startswith(cwd, ws.path .. "/") then
              return { bg = ws.color }
            end
          end
        end,
      },
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
