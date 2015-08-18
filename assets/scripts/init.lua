console:add("Console: Running init script...")

function cmd_sp(addr, port)
	local g = Gamestate.state
	g:startSingleplayer()
	-- print("Console: " .. tostring(g))
	-- .current:startSingleplayer()
end

console:bindCommand("sp", cmd_sp)