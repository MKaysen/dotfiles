return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  dependencies = {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  opts = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    local ascii = require("ascii")
    local logo = ascii.art.text.neovim.sharp

    logo = table.concat(logo, "\n")
    logo = logo .. string.rep("\n", 2)
    logo = vim.split(logo, "\n")

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = logo,
        center = {
          {
            action = function()
              builtin.find_files()
            end,
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = function()
              builtin.oldfiles()
            end,
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = function()
              builtin.live_grep()
            end,
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = function()
              telescope.extensions.chezmoi.find_files()
            end,
            desc = " Config",
            icon = " ",
            key = "c",
          },
          {
            action = 'lua require("persistence").load()',
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          {
            action = "Lazy",
            desc = " Lazy",
            icon = "󰒲 ",
            key = "l",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "⚡ Neovim loaded "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins in "
              .. ms
              .. "ms",
          }
        end,
        vertical_center = true,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
