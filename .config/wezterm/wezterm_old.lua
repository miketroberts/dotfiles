-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- Fancy tab bar cannot be themed by color schemes,
-- only by custom config
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.disable_default_key_bindings = true

-- Colors
config.colors = {
	foreground = "#e0e2ea",
	background = "#14161b",

	cursor_fg = "e0e2ea",
	cursor_bg = "#9b9ea4",
	cursor_border = "e0e2ea",

	selection_fg = "none",
	selection_bg = "#4f5258",

	-- The color of the split lines between panes
	split = "e0e2ea",

	-- dark nvim colors brightened 30%
	ansi = {
		"#07080d",
		"#ffc0b9",
		"#b3f6c0",
		"#fce094",
		"#a6dbff",
		"#ffcaff",
		"#8cf8f7",
		"#eef1f8",
	},
	brights = {
		"#9b9ea4",
		"#ffc0b9",
		"#b3f6c0",
		"#fce094",
		"#a6dbff",
		"#ffcaff",
		"#8cf8f7",
		"#eef1f8",
	},
	tab_bar = {
		background = "#2c2e33",
		active_tab = {
			bg_color = "#14161b",
			fg_color = "#e0e2ea",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#2c2e33",
			fg_color = "#c4c6cd",
		},
		inactive_tab_hover = {
			bg_color = "#4f5258",
			fg_color = "#e0e2ea",
			italic = true,
		},
		new_tab = {
			bg_color = "#2c2e33",
			fg_color = "#c4c6cd",
		},
		new_tab_hover = {
			bg_color = "#4f5258",
			fg_color = "#e0e2ea",
			italic = true,
		},
	},
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Keybindings
config.keys = {

	-- Window
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "m", mods = "ALT", action = act.Hide },
	{ key = "0", mods = "ALT", action = act.ResetFontSize },
	{ key = "+", mods = "ALT", action = act.IncreaseFontSize },
	{ key = "-", mods = "ALT", action = act.DecreaseFontSize },
	{ key = "/", mods = "SHIFT|ALT", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "?", mods = "SHIFT|ALT", action = act.QuickSelect },
	{ key = ":", mods = "SHIFT|ALT", action = act.ActivateCommandPalette },
	{ key = "r", mods = "ALT", action = act.ReloadConfiguration },
	{ key = "o", mods = "ALT", action = act.ShowDebugOverlay },

	-- Clipboard
	{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
	{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },

	-- Scroll similar to vim
	{ key = "u", mods = "ALT", action = act.ScrollByPage(-0.5) },
	{ key = "d", mods = "ALT", action = act.ScrollByPage(0.5) },
	{ key = "b", mods = "ALT", action = act.ScrollByPage(-1) },
	{ key = "f", mods = "ALT", action = act.ScrollByPage(1) },

	-- Tabs
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
	{ key = "p", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
	-- conflicts with reset font size
	-- { key = '0', mods = 'ALT', action = act.ActivateTab(9) },
	{ key = "ß", mods = "ALT", action = act.ActivateTab(-1) },

	-- Panes
	{ key = "%", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "'", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "h", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "j", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "k", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "l", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "DownArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "UpArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "RightArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
}

-- Directory name in tab title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local current_dir = (string.gsub(tab.active_pane.current_working_dir.path, "/$", ""))
	local home_dir = "/" .. wezterm.home_dir:gsub("\\", "/")
	return current_dir == home_dir and tab.tab_index + 1 .. ": ~ "
		or tab.tab_index + 1 .. ": " .. string.gsub(current_dir, "(.*[/\\])(.*)", "%2") .. " "
end)

-- or, changing the font size and color scheme.
config.font_size = 12

config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular" })

-- Finally, return the configuration to wezterm:
return config
