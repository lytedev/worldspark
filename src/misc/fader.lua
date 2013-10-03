require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Fader = Class{function(self, start, fade, initial, final, method, loops)
    self.start = start or 0
    self.fade = fade or 1
    self.initial = initial or 0
    self.final = final or 1

    self.method = method or "linear"
    self.loops = loops or false

    self:reset()

    self.onFinished = function() end
end}

function Fader:reset(start, face, initial, final, method, loops)
    self.start = start or self.start
    self.fade = fade or self.fade
    self.initial = initial or self.initial
    self.final = final or self.final

    self.method = method or self.method
    self.loops = loops or self.loops

    self.time = 0
    self.val = self.initial
end

function Fader:update(dt)
    local percentage = (self.time - self.start) / (self.fade)
    percentage = math.clamp(0, percentage, 1)
    if self.method == "cos" then
        percentage = math.clamp(0, math.abs(math.cos(percentage * (math.pi / 2)) - 1), 1)
    end
    local diff = self.final - self.initial
    local min = math.min(self.initial, self.final)
    local max = math.max(self.initial, self.final)
    self.val = math.clamp(min, self.initial + (percentage * diff), max)
    self.time = self.time + dt
    if self.time >= self.start + self.fade and not self.isFinished and self:onFinished() then
        self:onFinished()
        self.isFinished = true
    end
end

return Fader
