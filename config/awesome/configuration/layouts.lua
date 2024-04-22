local awful = require("awful")
local bling = require("modules.bling")
local lain = require("lain")

awful.layout.layouts = {
  lain.layout.centerwork,
  bling.layout.centered,
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.fair,
	awful.layout.suit.max,
}
