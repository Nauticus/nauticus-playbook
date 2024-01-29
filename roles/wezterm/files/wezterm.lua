-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font("Berkeley Mono")

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.freetype_load_target = "Normal"
config.freetype_load_flags = "NO_HINTING"

config.font_size = 13
config.enable_tab_bar = false
config.line_height = 1.0
config.window_decorations = "RESIZE"

config.window_padding = {
    left = "1cell",
    right = "1cell",
    top = "0.7cell",
    bottom = "0cell",
}

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
        horizontal_align = "Center",
        vertical_align = "Top",
        hsb = {
            brightness = 0.03,
        },
        opacity = 1,
        repeat_x = "NoRepeat",
    },
    {
        source = {
            Gradient = {
                orientation = {
                    Linear = {
                        angle = 135,
                    },
                },
                colors = {
                    "#000000",
                    wezterm.color.parse(original_bg_color):darken_fixed(0.01),
                },
                interpolation = "CatmullRom",
                blend = "Oklab",
                noise = 150,
            },
        },

        width = "100%",
        height = "100%",
        opacity = 0.5,
    },
}

config.cursor_blink_rate = 0
config.animation_fps = 144
config.text_background_opacity = 1
config.window_background_opacity = 1
config.bold_brightens_ansi_colors = "No"
config.cursor_thickness = "1pt"
config.max_fps = 144
config.disable_default_key_bindings = true
config.strikethrough_position = "0.5cell"

local act = wezterm.action

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
    -- Debug
    { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
    -- Quit
    { key = "q", mods = "CMD", action = act.QuitApplication },
    -- close current window
    { key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
    -- paste from clipboard
    { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
    -- spawn new window
    { key = "n", mods = "CMD", action = act.SpawnWindow },

    --increase font size
    { key = "!", mods = "LEADER", action = act.IncreaseFontSize },
    --decrease font size
    { key = "$", mods = "LEADER", action = act.DecreaseFontSize },
    -- reset font size
    { key = "*", mods = "LEADER", action = act.ResetFontSize },
    -- activate command palette
    { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
    -- char select without copying to clipboard
    { key = "u", mods = "LEADER", action = act.CharSelect({ copy_on_select = false }) },
}

return config
