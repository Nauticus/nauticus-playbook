-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("JetBrains Mono")

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 12.5
config.enable_tab_bar = false
config.line_height = 1.2
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "0cell",
	right = "0cell",
	top = "0cell",
	bottom = "0cell",
}
config.front_end = "WebGpu"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:

local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
local original_bg_color = colors.background
colors.background = "#000000"

config.color_schemes = {
	["Catppuccin_Custom"] = colors,
}

config.color_scheme = "Catppuccin_Custom"

config.background = {
	{
		source = {
			File = os.getenv("HOME") .. "/.config/wezterm/wallpaper.png",
		},
		hsb = {
			brightness = 0.03,
			hue = 1,
		},
		opacity = 1,
		repeat_x = "NoRepeat",
		height = "Cover",
	},
	{
		source = {
			-- Color = "black",
			Gradient = {
				orientation = "Vertical",
				colors = {
					"#000000",
					wezterm.color.parse(original_bg_color):darken_fixed(0.06),
				},
				blend = "Rgb",
				noise = 64,
			},
		},

		width = "100%",
		height = "100%",
		opacity = 0.5,
	},
}

config.cursor_blink_rate = 700
config.animation_fps = 144
config.text_background_opacity = 1
config.cursor_thickness = "1pt"
config.max_fps = 144
config.disable_default_key_bindings = true

local act = wezterm.action

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{ key = "q", mods = "CMD", action = act.QuitApplication },
	-- close current window
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	-- paste from clipboard
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	--increase font size
	{ key = "!", mods = "LEADER", action = act.IncreaseFontSize },
	--decrease font size
	{ key = "$", mods = "LEADER", action = act.DecreaseFontSize },
	-- reset font size
	{ key = "*", mods = "LEADER", action = act.ResetFontSize },
	-- spawn new window
	{ key = "n", mods = "LEADER", action = act.SpawnWindow },
	-- activate command palette
	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
	-- char select without copying to clipboard
	{ key = "u", mods = "LEADER", action = act.CharSelect({ copy_on_select = false }) },
}

return config
