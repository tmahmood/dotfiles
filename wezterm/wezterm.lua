-- Pull in the wezterm API
local wezterm = require 'wezterm'


-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

-- This table will hold the configuration.
local config = {}


-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = "RESIZE"
-- config.front_end = "WebGpu"
-- config.enable_wayland = false

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'iceberg-dark'
-- config.color_scheme = 'Iiamblack (terminal.sexy)'
-- config.color_scheme = 'darkmoss (base16)'
-- config.color_scheme = 'Default (dark) (terminal.sexy)'
-- config.color_scheme = 'Doom Peacock'
-- config.color_scheme = 'duckbones'
config.color_scheme = 'Banana Blueberry'
config.use_fancy_tab_bar = false
config.font = wezterm.font 'MartianMono Nerd Font Mono'
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab=true

scrollback_lines = 10000
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}


-- and finally, return the configuration to wezterm
return config

