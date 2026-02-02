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

function love.load()
end

function love.update(dt)
    if direction.up then
        player.pos.y = -dt
    elseif direction.down then
        player.pos.y = dt
    elseif direction.left then
        player.pos.x = -dt
    elseif direction.right then
        player.pos.x = -dt
    end
end

function love.draw()
    love.graphics.rectangle("fill", player.pos.x, player.pos.y, 10, 10)
end

function love.keypressed(key)
    for v in pairs({"up", "down", "left", "right"}) do
        if key == v then
            direction[v] = true
        else
            direction[v] = false
        end
    end
end
