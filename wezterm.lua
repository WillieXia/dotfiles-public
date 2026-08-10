-- wezterm.lua — github.com/WillieXia/dotfiles-public
--
-- Symlinked into place, so editing ~/.wezterm.lua edits this repo:
--   ln -sf ~/dotfiles-public/wezterm.lua ~/.wezterm.lua
--
-- WezTerm reloads on save. Cmd/Ctrl+Shift+L opens the debug overlay if
-- something in here throws.

local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Appearance ---------------------------------------------------------------

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Menlo",
  "DejaVu Sans Mono",
  "monospace",
})
config.font_size = 13.0
config.window_padding = { left = 12, right = 12, top = 12, bottom = 8 }
config.window_decorations = "RESIZE"

-- Only show the tab bar when it's actually telling you something.
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Behavior -----------------------------------------------------------------

config.scrollback_lines = 100000
config.audible_bell = "Disabled"
config.default_cursor_style = "BlinkingBar"
config.check_for_updates = false

-- Keys ---------------------------------------------------------------------
-- CMD on macOS, CTRL+SHIFT everywhere else. Built once as a plain string so
-- there's no accidental "CTRL|SHIFT|SHIFT" when combining modifiers.

local mod = wezterm.target_triple:find("darwin") and "CMD" or "CTRL|SHIFT"

config.keys = {
  { key = "d", mods = mod, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "e", mods = mod, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = mod, action = act.CloseCurrentPane({ confirm = true }) },
  { key = "LeftArrow", mods = mod, action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = mod, action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = mod, action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = mod, action = act.ActivatePaneDirection("Down") },
  { key = "f", mods = mod, action = act.ToggleFullScreen },
}

return config
