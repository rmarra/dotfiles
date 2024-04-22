local awful = require("awful")
local beautiful = require("beautiful")
local clientbuttons = require("configuration.client.buttons")
local clientkeys = require("configuration.client.keys")

awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},
	{
		rule_any = {
			instance = {
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"Sxiv",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			name = {},
			role = {},
		},
		properties = { floating = true },
	},

	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },
}
