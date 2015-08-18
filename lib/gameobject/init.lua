--[[

File: 		conf.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Represents an object in the game.

]]--

local Gameobject = Class{}

function Gameobject:init()
	self.position = vector(640 / 2, 360 / 1.5)
end

function Gameobject:update(dt)

end

function Gameobject:draw()

end

return Gameobject