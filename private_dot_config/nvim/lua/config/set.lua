vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim .opt.showmode = false

vim.opt.breakindent = true

vim.schedule(function ()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.confirm = true
