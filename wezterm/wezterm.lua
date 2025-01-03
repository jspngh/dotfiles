local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 18
config.font = wezterm.font 'Berkeley Mono'

config.initial_rows = 38
config.initial_cols = 108

config.color_scheme = 'OneHalfDark'
config.colors = {
    tab_bar = {
        inactive_tab = {
            bg_color = '#3e3e3e',
            fg_color = '#808080',
        },
        active_tab = {
            bg_color = '#181c24',
            fg_color = '#d0d0d0',
        },
    }
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_frame = {
    font_size = 14,
}

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    {
        key = 'F11',
        action = wezterm.action.ToggleFullScreen,
    },
}

return config
