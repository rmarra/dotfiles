pcall(require, "luarocks.loader")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local naughty = require("naughty")
local beautiful = require("beautiful")

naughty.persistence_enabled = true
naughty.config.defaults.ontop = true
naughty.config.defaults.padding = 8
naughty.config.defaults.timeout = 8
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.position = "top_right"

naughty.connect_signal("request::display", function(n)
	gears.debug.dump(n, "notification")
	n.timeout = 6
	local app_icon = n.app_icon or "/home/user/notification.png"
	local heading_widget = wibox.widget({
		nil,
		{
			widget = wibox.widget.textbox,
			markup = "<b>" .. naughty.config.defaults.title .. "</b>",
		},
		{
			widget = wibox.widget.textbox,
			text = "X",
		},
		layout = wibox.layout.align.horizontal,
	})

	local icon_widget = wibox.widget({
		{
			{
				widget = wibox.widget.imagebox,
				image = app_icon,
				resize = true,
				valign = "center",
			},
			widget = wibox.container.margin,
			margins = dpi(8),
		},
		widget = wibox.container.constraint,
		width = dpi(72),
		height = dpi(72),
		strategy = "max",
	})
	local widget = naughty.layout.box({
		notification = n,
		type = "notification",
		maximum_width = dpi(380),
		maximum_height = dpi(980),
		shape = gears.shape.rectangle,
		widget_template = {
			widget = wibox.container.background,
			bg = beautiful.notification_bg,
			shape = gears.shape.rounded_rect,
			{
				layout = wibox.layout.fixed.vertical,
				{
					widget = wibox.container.background,
					bg = "#f7c220",
					fg = "#000",
					{
						widget = wibox.container.margin,
						margins = dpi(8),
						heading_widget,
					},
				},
				{
					widget = wibox.container.margin,
					margins = dpi(8),
					{
						widget = wibox.layout.align.horizontal,
						icon_widget,
						{
							widget = wibox.layout.align.vertical,
							{
								widget = wibox.container.margin,
								bottom = dpi(4),
								{
									widget = wibox.widget.textbox,
									markup = "<b>" .. n.title .. "</b>",
								},
							},
							{
								widget = wibox.widget.textbox,
								text = n.message,
							},
						},
					},
				},
			},
		},
	})
end)
