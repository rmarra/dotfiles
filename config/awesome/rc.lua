-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local beautiful = require("beautiful")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("error_handler")

beautiful.init(gears.filesystem.get_configuration_dir() .. "default/theme.lua")

modkey = "Mod4"

require("configuration.layouts")
require("configuration.keys")
require("configuration.screen.signals")
require("configuration.client.signals")
require("configuration.notification")
require("configuration.rules")
