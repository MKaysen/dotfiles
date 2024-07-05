local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font {
    family = 'FiraCode Nerd Font Mono'
  }
end

return module

