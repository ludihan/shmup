local sti = require "lib.sti"
local direction = {
    up = false,
    down = false,
    left = false,
    right = false,
}

local player = {
    pos = { x = 0, y = 0 },
    slow = false,
}

local initShmup = false

function love.load()
    Map = sti("level.lua")
    width, height = love.graphics.getDimensions()
end

function love.update(dt)
    for _, v in ipairs({ "up", "down", "left", "right" }) do
        if love.keyboard.isDown(v) then
            direction[v] = true
        else
            direction[v] = false
        end
    end
    local distance = dt * 100
    if direction.up then
        player.pos.y = player.pos.y - distance
    end
    if direction.down then
        player.pos.y = player.pos.y + distance
    end
    if direction.left then
        player.pos.x = player.pos.x - distance
    end
    if direction.right then
        player.pos.x = player.pos.x + distance
    end

    if initShmup then
        for i, v in pairs(Map.objects) do
            v.y = v.y + dt * 100
            if v.y + 10 >= height * 0.2 and v.properties.movement then
                print(v.y)
                local f = load(v.properties.movement)
                print(f()(v))
                v.x = f()(v)
            end
            Map.objects[i] = v
        end
    end
end

function love.draw()
    Map:draw()
    love.graphics.rectangle("line", width * 0.3, height * 0.2, (width * 0.2) * 2, (height * 0.6))
    love.graphics.rectangle("fill", player.pos.x, player.pos.y, 10, 10)
    for i, v in pairs(Map.objects) do
        love.graphics.rectangle("fill", v.x, v.y, 10, 10)
    end
end

function love.keypressed(key)
    if key == "escape" or key == "q" then
        love.event.quit()
    end

    if key == "space" then
        initShmup = true
    end
end
