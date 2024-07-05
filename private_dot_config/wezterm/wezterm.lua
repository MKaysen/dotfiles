local wezterm = require 'wezterm'
local appearance = require 'appearance'
local common = require 'common'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

appearance.apply_to_config(config)
common.apply_to_config(config)

return config
