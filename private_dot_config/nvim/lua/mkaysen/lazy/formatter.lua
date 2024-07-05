return {
  "mhartington/formatter.nvim",
  config = function()
    require("formatter").setup({
      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua()
        },
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace()
        }
      }
    })
  end
}
