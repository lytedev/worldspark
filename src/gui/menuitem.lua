require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local GUIObject = require("gui.guiobject")

local MenuItem = Class{inherits = GUIObject, function(self, parent, position, size, alignment, children)
    GUIObject.construct(self, parent, position, size, alignment, children)
    self.backgroundColor = {11, 11, 11, 255}
    self.activeBackgroundColor = {33, 33, 33, 255}
    self.color = {255, 255, 255, 255}
    self.activeColor = {255, 255, 255, 255}
    self.font = nil
    self.padding = vector(0, 0)
    self.text = ""
end}

return MenuItem
