require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Logo = Class{function(self, img, time, quadData)
    self.image = img
    self.time = time

    if quadData then
        quadData = {quadData[1], quadData[2], quadData[3], quadData[4], self.image:getWidth(), self.image:getHeight()}
    else
        quadData = quadData or {0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getWidth(), self.image:getHeight()}
    end

    self.quad = love.graphics.newQuad(quadData[1], quadData[2], quadData[3], quadData[4], quadData[5], quadData[6])

    self.currentTime = 0
    self.isFinished = false

    self.onUpdate = function(dt) end
    self.onFinished = function() end
end}

function Logo:update(dt)
    if self.isFinished then return end

    self.currentTime = self.currentTime + dt
    if self.currentTime >= self.time then
        self.isFinished = true
        if self.onFinished then
            self:onFinished()
        end
    end

    if self.onUpdate then
        self.onUpdate(self, dt)
    end
end

function Logo:draw()
    love.graphics.setColor(255, 255, 255, 255)
    local qx, qy, qw, qh = self.quad:getViewport()
    local x = (love.graphics.getWidth() / 2) - (qw / 2)
    local y = (love.graphics.getHeight() / 2) - (qh / 2)
    love.graphics.drawq(self.image, self.quad, x, y)
    if self.onDraw then
        self:onDraw(self)
    end
end

return Logo
