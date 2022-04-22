local cmd = vim.cmd
local o = vim.o
local g = vim.g

cmd([[colorscheme nord]])
g.airline_powerline_fonts = 1

o.number = true
o.relativenumber = true

o.shiftwidth = 2
