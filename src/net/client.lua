--[[

File: 		client.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

A basic Lua networking client.

]]--

local libClient = require("lib.net.client")
local Packet = require("lib.net.packet")
local Client = Class{__includes=libClient}

function Client:init()
	libClient.init(self)
	self.printPacketInfo = 0

	self.packetHandler[2] = function(self, packet)
		local serverName = packet:readString()
		print("Client: Joined \"" .. serverName .. "\"")
	end
end

function Client:connect(addr, port)
	libClient.connect(self, addr, port)
	if self.connected then
		local p = Packet(1)
		p:addString(config.title .. "\n" .. config.identity .. "\n" .. config.titleVersion .. "\n" .. config.version)
		self:sendPacket(p)
	end
end

return Client