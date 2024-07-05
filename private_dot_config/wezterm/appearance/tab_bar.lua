local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false
end

return module

