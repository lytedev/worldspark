require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local MenuItem = require("gui.menuitem")
local Label = require("gui.label")

local titleVersionLabel = Label()
titleVersionLabel.font = assetManager:getFont("pxserif8")
titleVersionLabel.text = string.format("%s - %s\nCopyright (C) 2013\n%s\nAll Rights Reserved",
    config.title, config.identityVersion, config.author)
titleVersionLabel.color= {255, 255, 255, 50}
titleVersionLabel.activeColor = titleVersionLabel.color
titleVersionLabel.alignment = alignments.bottomleft
titleVersionLabel.position = vector(0, 10)

return titleVersionLabel
