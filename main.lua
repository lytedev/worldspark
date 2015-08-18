--[[

File: 		main.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Game entry point.

]]--

Gamestate = require("lib.hump.gamestate")
Class = require("lib.hump.class")
vector = require("lib.hump.vector")
assetManager = require("lib.assetmanager")()
defaultFont = love.graphics.newFont(9)
console = require("lib.console")(defaultFont, 10)
hooks = require("lib.hooks")
old_print = print
print = function(msg, from)
	console:add(msg, from)
end

local __newImage = love.graphics.newImage

function love.graphics.newImage( ... )
   local img = __newImage( ... )
   img:setFilter( 'nearest', 'nearest' )
   return img
end

function love.graphics.newSmoothImage( ... )
    return __newImage( ... )
end

function love.load(args)
	Gamestate.registerEvents()
	Gamestate.switch(require("src.scenes.game"))
	hooks.registerLoveCallbacks()

	dofile(assetManager:createScriptPath("init"))
end

function love.keypressed(k, u)
	console:keypressed(k, u)
end

function love.update(dt)
	console:update(dt)
end
