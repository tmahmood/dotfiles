-- Pull in the wezterm API
local wezterm = require 'wezterm'

local act = wezterm.action

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

-- config.window_decorations = "RESIZE"
-- config.front_end = "WebGpu"
-- config.enable_wayland = false

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'iceberg-dark'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Mashup Colors (terminal.sexy)'
-- config.color_scheme = 'Iiamblack (terminal.sexy)'
config.color_scheme = 'darkmoss (base16)'
-- config.color_scheme = 'Default (dark) (terminal.sexy)'
-- config.color_scheme = 'Doom Peacock'
-- config.color_scheme = 'duckbones'
-- config.color_scheme = 'Banana Blueberry'
-- config.color_scheme = 'Tokyo Night'
config.use_fancy_tab_bar = false
config.font = wezterm.font 'Departure Mono'
-- config.font = wezterm.font '0xProto Nerd Font'
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab=true

scrollback_lines = 10000
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.leader = { key = 'Space', mods = 'CTRL|SHIFT' }
config.keys = {
  -- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
  -- mode until we cancel that mode.
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  -- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
  -- mode until we press some other key or until 1 second (1000ms)
  -- of time elapses
  {
    key = 'a',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'activate_pane',
    },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'split_pane',
    },
  },
}

config.key_tables = {
  -- Defines the keys that are active in our resize-pane mode.
  -- Since we're likely to want to make multiple adjustments,
  -- we made the activation one_shot=false. We therefore need
  -- to define a key assignment for getting out of this mode.
  -- 'resize_pane' here corresponds to the name="resize_pane" in
  -- the key assignments above.
  resize_pane = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

  -- Defines the keys that are active in our activate-pane mode.
  -- 'activate_pane' here corresponds to the name="activate_pane" in
  -- the key assignments above.
  activate_pane = {
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
  },

  split_pane = {
    { key = 'h', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
    { key = 'v', action = act.SplitVertical { domain = 'CurrentPaneDomain' }},
  },
}


-- and finally, return the configuration to wezterm
return config

