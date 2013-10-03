require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local GUIObject = Class{function(self, parent, position, size, alignment, children)
    if type(parent) ~= "table" then
        parent = GUIParent
    end
    self.parent = parent
    self.size = size or vector(0, 0)
    self.position = position or vector(0, 0)
    if not alignment and parent then
        self.alignment = parent.alignment
    else
        self.alignment = alignment or alignments.topleft
    end
    self.children = children or {}
    if parent then
        parent:addChild(self)
    end
end}

function GUIObject:focus()
    GUIParent.focus = self
end

function GUIObject:unfocus()
    if GUIParent.focus == self then
        GUIParent.focus = nil
    end
end

function GUIObject:addChild(child)
    if child.parent ~= nil then
        for i = 1, #child.parent.children, 1 do
            if child.parent.children[i] == child then
                table.remove(child.parent.children, i)
                break
            end
        end
    end
    self.children[#self.children + 1] = child
    child.parent = self
end

function GUIObject:setParent(parent)
    parent:addChild(self)
end

function GUIObject:update(dt)
    if self.parent == nil then
        self.size = vector(love.graphics.getWidth(), love.graphics.getHeight())
    end
    for i = 1, #self.children, 1 do
        self.children[i]:update(dt)
    end
end

function GUIObject:draw()
    for i = 1, #self.children, 1 do
        self.children[i]:draw(opacity)
    end
end

function GUIObject:getBounds()
    local bounds = {0, 0, 0, 0}
    if self.parent ~= nil then
        -- bounds = self.parent:getBounds()
        bounds = self:getParentBounds()
    else
        bounds = {self.position.x, self.position.y, self.size.x, self.size.y}
    end
    return bounds
end

function GUIObject:getParentBounds()
    if self.parent ~= nil then
        return {self.parent.position.x, self.parent.position.y, self.parent.size.x, self.parent.size.y}
    end
end

function GUIObject:getAlignedDimensions(pretendSize)
    if type(pretendSize) ~= "table" then
        pretendSize = self.size
    end
    return getAlignedDimensions(self.position, pretendSize, self:getBounds(), self.alignment)
end

return GUIObject
