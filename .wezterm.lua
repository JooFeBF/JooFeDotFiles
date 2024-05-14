-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("CaskaydiaCove Nerd Font")
-- enable with your own background image
--
config.background = {
	{
		source = {
			File = "./Downloads/taigawp.jpg",
		},
		hsb = {
			brightness = 0.1,
		},
	},
}

config.hide_tab_bar_if_only_one_tab = true
-- and finally, return the configuration to wezterm
return config
