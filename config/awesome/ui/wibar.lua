local awful = require("awful")
local wibox = require("wibox")
local tagbar = require("ui.tagbar")
local taskbar = require("ui.taskbar")
local layoutbox = require("ui.layout")

return function(s)
	local promptbox = awful.widget.prompt()
	local keyboardlayout = awful.widget.keyboardlayout()
	local textclock = wibox.widget.textclock()
	local wibox_tagbar = tagbar.build(s)
	local wibox_taskbar = taskbar.build(s)
	local wibox_layoutbox = layoutbox(s)

	local mywibox = awful.wibar({ position = "top", screen = s })
	mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			wibox_tagbar,
			promptbox,
		},
		wibox_taskbar, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			keyboardlayout,
			wibox.widget.systray(),
			textclock,
			wibox_layoutbox,
		},
	})
end
