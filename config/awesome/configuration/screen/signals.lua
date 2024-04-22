local capi = { screen = screen, client = client, awesome = awesome }
local awful = require("awful")
local wallpaper_manager = require("configuration.screen.wallpaper")
local wibar = require("ui.wibar")

capi.screen.connect_signal("property::geometry", wallpaper_manager.set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	wallpaper_manager.set_wallpaper(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	s.wibar = wibar(s)
end)
