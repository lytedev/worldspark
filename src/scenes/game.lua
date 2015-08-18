--[[

File: 		game.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Game scene.

]]--

local Game = {}

local Server = require("src.net.server")
local Client = require("src.net.client")
local Packet = require("lib.net.packet")

settings = {}

function Game:init()
	local sans11 = assetManager:getFont('opensans_light', 20, 'sans11')
	local px8 = assetManager:getFont('pf_tempesta_seven_condensed', 8, 'px8')
	local pxs8 = assetManager:getFont('pf_westa_seven_condensed', 8, 'pxs8')

	self.name = "game" -- All gamestates should have a name with which scripts can identify the current gamestate
	
	local Camera = require("lib.hump.camera")
	self.camera = Camera()
	self.camera:zoomTo(2)

	console:setFont(px8, 10)

	self.netTimer = 0
	self.netUpdateTime = (1 / config.networkUPS)

	local Sprite = require("lib.gameobject.sprite")
	local AnimationGroup = require("lib.animation.group")
	local AnimationSet = require("lib.animation.set")
	local AnimationFrame = require("lib.animation.frame")

	local frames = AnimationFrame.generate(128, 128, 128 * 8, 128 * 8, 8 * 8, 0.05)
	local animSet = AnimationSet(frames)
	local animGroup = AnimationGroup({
		{"default", animSet}
		})
	local blueFire = assetManager:getImage("explosion/explosionframes")
	self.testSprite = Sprite(blueFire, animGroup)

  self.camera:lookAt((self.testSprite.position + (vector(128, 128) / 2)):unpack())

	-- console:toggle()
	console.size[2] = -15
end

function Game:update(dt)
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	self.testSprite:update(dt)

	self.netTimer = self.netTimer + dt
	if self.netTimer > self.netUpdateTime then
		self:netUpdate(dt)
		self.netTimer = self.netTimer - ((math.floor(self.netTimer / self.netUpdateTime)) * self.netUpdateTime)
	end
end

function Game:draw()
	self.camera:attach()
	self.testSprite:draw()
	self.camera:detach()

	love.graphics.setFont(assetManager:getFont("px8"))
	local y = love.graphics.getHeight() - love.graphics.getFont():getHeight() - 5
	love.graphics.setColor(255, 255, 255, 128)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. " | CMD: " .. tostring(console.currentCommand) .. ": " .. console.commands[console.currentCommand], 5, y)
	console:draw()
end

function Game:netUpdate(dt)
	if self.server then
		self.server:update(dt)
	end
	if self.client then
		self.client:update(dt)
	end
end

function Game:startSingleplayer(port)
	print("Game: Starting singleplayer")
	self:host("127.0.0.1", port)
end

function Game:host(addr, port)
	local addr = addr or "*"
	local port = port or 8888
	if self.server then
		print("Server: You are already hosting a server!")
	elseif self.client then
		print("Client: You are already connected to a server!")
	else
		self.server = Server()
		self.server:host(addr, port)
		if addr == '*' then
			addr = '127.0.0.1'
		end
		self.client = Client()
		self.client:connect(addr, port)
	end
end

function Game:join(addr, port)
	local addr = addr or "*"
	local port = port or 8888
	if self.server then
		print("Server: You are already hosting a server!")
	elseif self.client then
		print("Client: You are already connected to a server!")
	else
		if addr == '*' then
			addr = '127.0.0.1'
		end
		self.client = Client()
		self.client:connect(addr, port)
	end
end

function Game:disconnect()
	-- TODO: Send d/c packet(s)
	self.server = nil
	self.client = nil
	print("Client: Disconnected")
	print("Server: Closed")
end

function Game:keypressed(k, u)
	if k == "tab" then
		console:toggle()
	end
	if console.stealInput then
		return
	end
  if k == "r" then
    Game.init(Game)
  end
end

return Game
