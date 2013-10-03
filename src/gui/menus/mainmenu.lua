require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Gamestate = require("hump.gamestate")
local Menu = require("gui.menu")
local Label = require("gui.label")
local Button = require("gui.button")
local Fader = require("misc.fader")

local mainMenu = Gamestate.new()

function mainMenu:init()
    local titleFont = assetManager:getFont("pxserif32")
    local buttonFont = assetManager:getFont("pxserif16")

    self.sword = love.graphics.newImage(assetManager:createImagePath("sword64"))
    self.swordHover = 0
    self.backdrop = love.graphics.newImage(assetManager:createImagePath("mainmenu"))
    self.overlayFader = Fader(0, 0.2, 255, 0)

    self.onSwitchTo = function(self)
        self.overlayFader:reset()
    end

    self.menu = Menu()
    self.menu.position = vector(40, 30)
    local w = titleFont:getWidth(config.title)
    self.menu.size = vector(w, love.graphics.getHeight() - (self.menu.position.y * 2))

    local title = Label(self.menu, vector(0, 0))
    title.color = {255, 255, 255, 255}
    title.font = titleFont
    title.text = config.title

    self.focusable = {}

    local button = Button(self.menu, vector(-self.menu.position.x, 80))
    button.text = "Play"
    button.font = buttonFont
    button.padding = vector(self.menu.position.x, 5)
    button.size = vector(w + 40, button.font:getHeight() + button.padding.y * 2)
    button.onSelect = function()
        local game = require("scenes.game")
        Gamestate.switch(game)
    end
    button:focus()

    local button2 = Button(self.menu, button.position + vector(0, button.font:getHeight() + button.padding.y * 3))
    button2.text = "Settings"
    button2.font = button.font
    button2.size = button.size
    button2.padding = button.padding

    local button3 = Button(self.menu, button2.position + vector(0, button.font:getHeight() + button.padding.y * 3))
    button3.text = "Quit"
    button3.font = button.font
    button3.size = button.size
    button3.padding = button.padding
    button3.onSelect = function() love.event.quit() end

    local tvi = require("gui.labels.titleversioninfo")
    tvi:setParent(self.menu)
end

function mainMenu:update(dt)
    self.swordHover = self.swordHover + (dt * 2)
    self.menu.size = vector(self.menu.size.x, love.graphics.getHeight() - (self.menu.position.y * 2))
    local x, y = love.mouse.getPosition()
    for i = 1, #self.menu.children, 1 do
        local pb = self.menu.children[i]
        if pb:is_a(Button) then
            d = pb:getAlignedDimensions()
            if isPointInRect(x, y, d[1], d[2], d[3], d[4]) then
                pb:focus()
                if love.mouse.isDown("l") then
                    if pb.onSelect then
                        pb.onSelect()
                    end
                end
            end
        end
    end

    self.overlayFader:update(dt)

    self.menu:update(dt)
end

function mainMenu:draw()
    -- getAlignedDimensions(position, size, bounds, alignment)
    love.graphics.setColor({255, 255, 255, 255})
    local scale = love.graphics.getHeight() / config.screen.scaleHeight

    local bdd = getAlignedDimensions(vector(0, 0),
        vector(self.backdrop:getWidth(), self.backdrop:getHeight()) * scale,
        {0, 0, love.graphics:getWidth(), love.graphics:getHeight()},
        alignments.bottomright)

    local bdpos = vector(bdd[1], bdd[2])
    love.graphics.draw(self.backdrop, bdpos.x, bdpos.y, 0, scale, scale, 0, 0)

    local sx = 56
    local sy = 0
    local sw = 16
    local sh = 80
    local q = love.graphics.newQuad(sx, sy, sw, sh, self.sword:getWidth(), self.sword:getHeight())
    local sdm = getAlignedDimensions(vector(80, 0) * scale,
        vector(sw, sh) * scale,
        {0, 0, love.graphics:getWidth(), love.graphics:getHeight()},
        alignments.bottomright)
    local pos = vector(math.floor(sdm[1]), math.floor(sdm[2] + (math.cos(self.swordHover) * (5 * scale))))
    pos = pos
    love.graphics.drawq(self.sword, q, pos.x, pos.y, math.rad(270), scale, scale, sw / 2, sh / 2)

    love.graphics.setColor({0, 0, 0, 220})
    local menubgp = self.menu.position
    love.graphics.rectangle("fill", self.menu.position.x - 40,
        self.menu.position.y - 40,
        self.menu.size.x + 80,
        self.menu.size.y + 80)
    love.graphics.setColor({255, 255, 255, 50})
    love.graphics.rectangle("fill", self.menu.position.x + self.menu.size.x + 40,
        0, 1, self.menu.size.y + 80)

    self.menu:draw(dt)

    local r, g, b, a = love.graphics.getBackgroundColor()
    a = self.overlayFader.val
    love.graphics.setColor({r, g, b, a})
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor({255, 255, 255, 255})
    love.graphics.setFont(assetManager:getFont("pixel8"))
    debugText = debugText .. "FPS: " .. love.timer.getFPS() .. "\n"
    love.graphics.print(debugText, 5, 5)
    debugText = ""
end

function mainMenu:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "up" or key == "w" then
        -- TODO Scrolling with keys
    end

    if key == "down" or key == "s" then

    end

    if key == "return" or key == "x" or key == "l" then
        print(type(GUIParent.focus))
        GUIParent.focus:onSelect()
    end
end

return mainMenu
