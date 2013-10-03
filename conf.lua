--[[

File: 		conf.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Sets the default configuration values for the LOVE2D framework.

]]--

function love.run()

    math.randomseed(os.time())

    if love.load then love.load(arg) end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
        if love.graphics then
            love.graphics.clear()
            if love.draw then love.draw() end
        end

        -- if love.timer then love.timer.sleep(0.001) end
        if love.graphics then love.graphics.present() end

    end

end

function love.conf(t)
	-- Set config global
	config = t

	t.title = "Worldspark"
	t.author = "Daniel \"lytedev\" Flanagan"
	t.url = "http://lytedev.com/worldspark"
	t.identity = "worldspark"
	t.titleVersion = "0.1.0"
	t.version = "0.8.0"

	t.release = false

	if not release then
		print(string.format("%s\n%s\n%s\n%s", t.title, t.titleVersion, t.author, t.url))
		print("TODO: Modify conf.lua and release")
	end

	t.console = false


	t.screen.scaleHeight = 180
	t.screen.width = 640
	t.screen.height = 360
	t.screen.fullscreen = false
	t.screen.vsync = false
	t.screen.fsaa = 0

	t.modules.joystick = true
	t.modules.audio = true
	t.modules.keyboard = true
	t.modules.event = true
	t.modules.image = true
	t.modules.graphics = true
	t.modules.timer = true
	t.modules.mouse = true
	t.modules.sound = true
	t.modules.physics = false

	t.networkUPS = 10

	t.settings = {}

	return t
end

function bytes_to_int(str, endian, signed)
    local t = {str:byte(1, -1)}
    if endian == "big" then --reverse bytes
        local tt = {}
        for k = 1, #t do
            tt[#t - k + 1] = t[k]
        end
        t = tt
    end
    local n = 0
    for k = 1, #t do
        n = n + t[k] * 2 ^ ((k - 1) * 8)
    end
    if signed then
        n = (n > 2 ^ (#t - 1) -1) and (n - 2 ^ #t) or n -- if last bit set, negative.
    end
    return n
end

function int_to_bytes(num, endian, signed)
    if num < 0 and not signed then num = -num end
    local res = {}
    local n = math.ceil(select(2, math.frexp(num)) / 8)
    if signed and num < 0 then
        num = num + 2 ^ n
    end
    for k = n, 1, -1 do -- 256 = 2^8 bits per char.
        local mul = 2 ^ (8 * (k - 1))
        res[k] = math.floor(num / mul)
        num = num - res[k] * mul
    end
    assert(num == 0)
    if endian == "big" then
        local t = {}
        for k = 1, n do
            t[k] = res[n - k + 1]
        end
        res = t
    end
    return string.char(unpack(res))
end

function string.trim(str)
    return string.match(str, '^%s*(.-)%s*$') or ''
end

function string.insert(str, s2, i)
	local i = i or string.len(str)
	local s = string.sub(str, 1, i) .. tostring(s2) .. string.sub(str, i + 1, string.len(str))
	return s
end

function string_bytes(str)
	local dstr = {string.byte(str, 1, string.len(str))}
	s = ""
	for i = 1, #dstr, 1 do
		s = s .. tostring(dstr[i]) .. " "
	end
	return s
end

function dofile(file, name)
	local ok, chunk = pcall(love.filesystem.load, file)
	if not ok then
		print("Error: " .. tostring(chunk))
	else
		local result
		ok, result = pcall(chunk)
		if not ok then
			print("Error: " .. tostring(result))
		else
			-- print("Console: " .. tostring(result))
			-- Scripts do not have a result printed
		end
	end
end

function dostring(str)
	local ok, f, e = pcall(loadstring, str)
	if not ok then
		print("Error: " .. tostring(f))
	else
		local result
		ok, result = pcall(f)
		if not ok then
			print("Error: " .. tostring(result))
		else
			print("Console: " .. tostring(result))
		end
	end
end

function table.address(t)
    return tostring(t):sub(8)
end
