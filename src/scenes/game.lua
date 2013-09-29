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
	
	console:setFont(px8, 10)

	self.netTimer = 0
	self.netUpdateTime = (1 / config.networkUPS)

	console.input = "/sp"
	console.inputCursor = #console.input
	console:toggle()
	console.size[2] = -30
end

function Game:update(dt)
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	self.netTimer = self.netTimer + dt
	if self.netTimer > self.netUpdateTime then
		self:netUpdate(dt)
		self.netTimer = self.netTimer - ((math.floor(self.netTimer / self.netUpdateTime)) * self.netUpdateTime)
	end
end

function Game:netUpdate(dt)
	if self.server then 
		self.server:update(dt)
	end
	if self.client then 
		self.client:update(dt)
	end
end

function Game:startSingleplayer()
	if self.server then
		print("Server: You are already hosting a server!")
	elseif self.client then
		print("Client: You are already connected to a server!")
	else
		print("Game: Starting singleplayer")
		self.server = Server()
		self.server:host()
		self.client = Client()
		self.client:connect()
	end
end

function Game:disconnect()
	-- TODO: Send d/c packet(s)
	
end

function Game:keypressed(k, u)
	if k == "tab" then
		console:toggle()
	end
	if console.stealInput then
		return
	end
end

function Game:draw()
	love.graphics.setFont(assetManager:getFont("px8"))
	local y = love.graphics.getHeight() - love.graphics.getFont():getHeight() - 5
	love.graphics.setColor(255, 255, 255, 128)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. " | CMD: " .. tostring(console.currentCommand) .. ": " .. console.commands[console.currentCommand], 5, y)
	console:draw()
end

function Game:__tostring()
	return "lol"
end

return Game