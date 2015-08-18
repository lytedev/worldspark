console:add("Console: Running init script...")

function cmd_sp(addr, port)
	local g = Gamestate.current()
	g:startSingleplayer()
end

console:bindCommand("sp", cmd_sp)
