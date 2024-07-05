local wezterm = require 'wezterm'

local module = {}

local function scheme_for_appearance()
  local appearance = wezterm.gui.get_appearance()

  if appearance:find 'Dark' then
    return 'Catppuccin Mocha'
  else
    return 'Catppuccin Latte'
  end
end

function module.apply_to_config(config)
  config.color_scheme = scheme_for_appearance()
end

return module

