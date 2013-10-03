--[[

File: 		conf.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

A gameobject with an animation state.

]]--

local Gameobject = require("src.gameobject")
local AnimationState = require("src.animation.state")

local Sprite = Class{__includes = {Gameobject, AnimationState}}

function Sprite:init(image, animationGroup, size, position)
	old_print(self)
    Gameobject.init(self, vector(0, 0), size, position)
    AnimationState.init(self, image, animationGroup, size)
end

function Sprite:update(dt)
    Gameobject.update(self, dt)
    AnimationState.update(self, dt)
end

function Sprite:draw()
    Gameobject.draw(self)
    AnimationState.draw(self, self.position)
end

return Sprite
