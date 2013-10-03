require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")
local GUIObject = require("gui.guiobject")

local Menu = Class{inherits = GUIObject, function(self, parent, position, size, alignment, children)
    GUIObject.construct(self, parent, position, size, alignment, children)
end}

return Menu
