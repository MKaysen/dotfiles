local font = require 'appearance.font'
local theme = require 'appearance.theme'
local tab_bar = require 'appearance.tab_bar'

local module = {}

function module.apply_to_config(config)
  font.apply_to_config(config)
  theme.apply_to_config(config)
  tab_bar.apply_to_config(config)
end

return module
