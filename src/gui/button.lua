require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local MenuItem = require("gui.menuitem")
local Label = require("gui.label")

local Button = Class{inherits = Label, function(self, parent, position, size, alignment, children)
    MenuItem.construct(self, parent, position, size, alignment, children)
    self.onSelect = nil
    self.backgroundColor = {11, 11, 11, 255}
    self.activeBackgroundColor = {33, 33, 33, 255}
    self.color = {255, 255, 255, 255}
    self.activeColor = {255, 80, 0, 255}
end}

function Button:update(dt)
    Label.update(self, dt)
end

function Button:draw()
    Label.draw(self)
    -- love.graphics.print(string.format("%i, %i - %i, %i, %i, %i", x, y, d[1], d[2]. d[3], d[4]), 0, 0)
    -- love.graphics.print(string.format("%i, %i - " .. self.size.x, x, y), 0, 0)
end

return Button
