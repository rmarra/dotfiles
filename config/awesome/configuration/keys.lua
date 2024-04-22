local capi = { awesome = awesome, client = client }
local awful = require("awful")
local helper = require("helper")
local scratchpad = require("scratchpad")
local user_preferences = require("user_preferences")

local mod = user_preferences.modkey
local ctrl = "Control"
local shift = "Shift"

awful.keyboard.append_global_keybindings({
	--- Apps
	--- Terminal
	awful.key({ mod }, "Return", function()
		awful.spawn("wezterm")
	end, { description = "open terminal", group = "app" }),

	--- Launcher
	awful.key({ mod }, "d", function()
		awful.spawn("sh /home/rmarra/.config/rofi/launchers/type-4/launcher.sh")
	end, { description = "open terminal", group = "app" }),

	--- Web browser
	awful.key({ mod, shift }, "w", function()
		awful.spawn("firefox")
	end, { description = "open web browser", group = "app" }),

	--- AwesowmWM
	--- Restart awesome
	awful.key({ mod, ctrl }, "r", capi.awesome.restart, { description = "reload awesome", group = "WM" }),

	--- Quit awesome
	awful.key({ mod, ctrl }, "q", capi.awesome.quit, { description = "quit awesome", group = "WM" }),

	--- Misc
	--- Screenshot
	awful.key({}, "Print", function()
		awful.spawn.with_shell("maim -s | xclip -selection clipboard -t image/png")
	end),

	awful.key({ "Shift" }, "Print", function()
		awful.spawn.with_shell("maim ~/Pictures/$(date +%Y%m%dT%H%M%S).png")
	end),

	--- Scratchpad
	awful.key({ mod, "Shift" }, "Return", function()
		scratchpad.obsidian_work:toggle()
	end, { description = "toggle scratchpad", group = "client" }),

	awful.key({ mod }, "p", function()
		scratchpad.obsidian_personal:toggle()
	end, { description = "toggle scratchpad", group = "client" }),

	--- Client
	--- Focus client by direction
	awful.key({ mod }, "k", function()
		awful.client.focus.bydirection("up")
	end, { description = "focus up", group = "client" }),

	awful.key({ mod }, "j", function()
		awful.client.focus.bydirection("down")
	end, { description = "focus down", group = "client" }),

	awful.key({ mod }, "h", function()
		awful.client.focus.bydirection("left")
	end, { description = "focus left", group = "client" }),

	awful.key({ mod }, "l", function()
		awful.client.focus.bydirection("right")
	end, { description = "focus right", group = "client" }),

	--- Swap client by direction
	awful.key({ mod, ctrl }, "k", function()
		awful.client.swap.bydirection("up")
	end, { description = "swap up", group = "client" }),

	awful.key({ mod, ctrl }, "j", function()
		awful.client.swap.bydirection("down")
	end, { description = "swap down", group = "client" }),

	awful.key({ mod, ctrl }, "h", function()
		awful.client.swap.bydirection("left")
	end, { description = "swap left", group = "client" }),

	awful.key({ mod, ctrl }, "l", function()
		awful.client.swap.bydirection("right")
	end, { description = "swap right", group = "client" }),

	--- Resize focused client
	awful.key({ mod, shift }, "k", function()
		helper.resize_client(capi.client.focus, "up")
	end, { description = "resize to the up", group = "client" }),

	awful.key({ mod, shift }, "j", function()
		helper.resize_client(capi.client.focus, "down")
	end, { description = "resize to the down", group = "client" }),

	awful.key({ mod, shift }, "h", function()
		helper.resize_client(capi.client.focus, "left")
	end, { description = "resize to the left", group = "client" }),

	awful.key({ mod, shift }, "l", function()
		helper.resize_client(capi.client.focus, "right")
	end, { description = "resize to the right", group = "client" }),
})

awful.keyboard.append_global_keybindings({
	--- Set tilling layout
	awful.key({ mod }, "s", function()
		awful.layout.set(awful.layout.suit.tile)
	end, { description = "set tile layout", group = "layout" }),

	--- Set floating layout
	awful.key({ mod, shift }, "s", function()
		awful.layout.set(awful.layout.suit.floating)
	end, { description = "set floating layout", group = "layout" }),
})

--- Move through workspaces
--- ~~~~~~~~~~~~~~~~~~~~~~~
awful.keyboard.append_global_keybindings({
	awful.key({ mod }, "[", awful.tag.viewprev, { description = "view previous", group = "tags" }),

	awful.key({ mod }, "]", awful.tag.viewnext, { description = "view next", group = "tags" }),

	awful.key({
		modifiers = { mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tags",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),

	awful.key({
		modifiers = { mod, ctrl },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tags",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),

	awful.key({
		modifiers = { mod, shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tags",
		on_press = function(index)
			if capi.client.focus then
				local tag = capi.client.focus.screen.tags[index]
				if tag then
					capi.client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
})
