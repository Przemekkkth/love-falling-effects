FallingRain = Object:extend()

function FallingRain:new()
    self.drops = {}
    for i = 1, 1500 do
        table.insert(self.drops, Drop())
    end 
end

function FallingRain:update(dt)
    for k,value in pairs(self.drops) do
        value:update(dt)
    end
end

function FallingRain:draw()
    local font = love.graphics.getFont()
    local fontWidth = font:getWidth("Falling Rain")
    local fontHeight = font:getHeight()
    -- love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )
    love.graphics.print("Falling Rain", WIDTH / 2, 50, 0, 1, 1, fontWidth / 2, fontHeight / 2)
    for k,value in pairs(self.drops) do
        value:draw()
    end
end