local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'MaterialDark'
config.font_size = 18
config.font = wezterm.font 'Berkeley Mono'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
