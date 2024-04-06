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
    love.graphics.print("Falling Rain", 0, 0)
    for k,value in pairs(self.drops) do
        value:draw()
    end
end