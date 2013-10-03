require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local MenuItem = require("gui.menuitem")

local Label = Class{inherits = MenuItem, function(self, parent, position, size, alignment, children)
    MenuItem.construct(self, parent, position, size, alignment, children)
    self.backgroundColor = {11, 11, 11, 0}
    self.activeBackgroundColor = {33, 33, 33, 0}
    self.color = {255, 255, 255, 255}
    self.activeColor = {255, 255, 255, 255}
    self.text = "Label"
end}

function Label:draw()
    local bgcol = self.backgroundColor
    local col = self.color
    if GUIParent.focus == self then
        col = self.activeColor
        bgcol = self.activeBackgroundColor
    end

    local pw = self.font:getWidth(self.text)
    w, h = self.font:getWrap(self.text, pw+1)
    h = h * self.font:getHeight()
    td = self:getAlignedDimensions(vector(w, h))
    d = self:getAlignedDimensions()
    love.graphics.setColor(bgcol)
    love.graphics.rectangle("fill",d[1], d[2], d[3], d[4])
    if self.font ~= nil then
        love.graphics.setFont(self.font)
        love.graphics.setColor(col)
        love.graphics.print(self.text, td[1] + self.padding.x, td[2] + self.padding.y)
    end
end

return Label
