--[[

File: 		assets/scripts/init.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

A test script for the scripting engine.

]]--

local cmd_commands = {
	command = "commands",
	aliases = {"command", "cmd"},
	name = "Commands",
	description = "Prints a list of available commands or details for a given command",
	args = {
		{
			name = "command",
			data = "text",
			description = "The command you would like detailed information about.",
			default = nil
		}
	},
	callback = function(command)
		local pairs = pairs
		local ipairs = ipairs
		if command then
			commandStr = console:getAlias(command) or command
			command = console.commandHandler[commandStr]
			if not command then 
				print("Error: Could not find command '" .. commandStr .. "'")
				return
			end
			old_print(command.command)
			local a = "No arguments."
			if command.args then
				a = "\n"
				old_print(#command.args)
				for k, v in ipairs(command.args) do
					a = a .. string.format("|--- %s (%s | Default: %s)\n|----- %s\n", v.name, v.data, tostring(v.default or "None"), v.description)
				end
			end
			local aliases = command.command
			if command.aliases then
				for k, v in pairs(command.aliases) do
					aliases = aliases .. ", " .. v
				end
			end
			print(string.format("Console: %s: %s\n|- %s\n|- Arguments%s", command.name, aliases, command.description, a))
		else
			local s = "Console: == Commands ==\n"
			local i = 1
			for k, v in pairs(console.commandHandler) do
				s = s .. tostring(i) .. ". " .. v.command .. "\n"
				i = i + 1
			end
			print(s)
		end
	end
}

local cmd_host = {
	command = "host",
	aliases = {},
	name = "Host",
	description = "Hosts a server at the specified address and port.",
	args = {
		{
			name = "address",
			data = "text",
			description = "The IP address or hostname you want to host on.",
			default = "*"
		},
		{
			name = "port",
			data = "number",
			description = "The port you want to listen on.",
			default = 8888
		}
	},
	callback = function(addr, port)
		local g = Gamestate.current()
		if g.name == 'game' then
			g:host(addr or "*", port or 8888)
		end		
	end
}

local cmd_join = {
	command = "join",
	aliases = {},
	name = "Join",
	description = "Join a server at the specified address and port.",
	args = {
		{
			name = "address",
			data = "text",
			description = "The IP address or hostname of the server you want to join.",
			default = "127.0.0.1"
		},
		{
			name = "port",
			data = "number",
			description = "The port of the server.",
			default = 8888
		}
	},
	callback = function(addr, port)
		local g = Gamestate.current()
		if g.name == 'game' then
			g:join(addr or "*", port or 8888)
		end		
	end
}

local cmd_help = {
	command = "help",
	aliases = {"h", "?", "halp"},
	name = "Help",
	description = "Prints the help menu to the console.",
	callback = function()
		console:help()
	end
}

local cmd_exit = {
	command = "exit",
	aliases = {"quit"},
	name = "Quit Game",
	description = "Closes the game.",
	callback = function()
		love.event.quit()
	end
}

local cmd_singleplayer = {
	command = "singleplayer",
	aliases = {"sp"},
	name = "Start Singleplayer",
	description = "Starts a singleplayer game.",
	callback = function()
		local g = Gamestate.current()
		if g.name == 'game' then
			g:startSingleplayer()
		else

		end
	end
}

local cmd_disconnect = {
	command = "disconnect",
	aliases = {"dc", "leave"},
	name = "Disconnect",
	description = "Leaves the current game.",
	callback = function()
		local g = Gamestate.current()
		if g.name == 'game' then
			g:disconnect()
		end
	end
}

console:bindCommand(cmd_host)
console:bindCommand(cmd_join)
console:bindCommand(cmd_commands)
console:bindCommand(cmd_help)
console:bindCommand(cmd_exit)
console:bindCommand(cmd_singleplayer)
console:bindCommand(cmd_disconnect)
