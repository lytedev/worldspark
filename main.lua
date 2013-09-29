--[[

File: 		main.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Game entry point.

]]--

Gamestate = require("lib.hump.gamestate")
Class = require("lib.hump.class")

assetManager = require("lib.assetmanager")()
defaultFont = love.graphics.newFont(9)
console = require("lib.console")(defaultFont, 10)
old_print = print
print = function(msg, from)
	console:add(msg, from)
end

function love.load(args)
	if not release then
		print("Args: " .. table.concat(args, "\n"))
	end

	Gamestate.registerEvents()
	Gamestate.switch(require("src.scenes.game"))

	require("io")
	print(Gamestate:current())
	old_print("Loading init script...")
	io.flush()
	dofile(assetManager:createScriptPath("init"))
	old_print("Loaded init script")
	io.flush()
end

function love.keypressed(k, u)
	console:keypressed(k, u)
end

function love.update(dt)
	console:update(dt)
end