Drop = Object:extend()

function Drop:new()
    self.x = love.math.random(WIDTH)
    self.y = love.math.random(450) - 500
    self.z = love.math.random(20)
    self.len = self:map(self.z, 0, 20, 10, 20)
    self.yspeed = self:map(self.z, 0, 20, 1, 20)
end

function Drop:update(dt)
    self.y = self.y + self.yspeed
    local grav = self:map(self.z, 0, 20, 0, 0.2)
    self.yspeed = self.yspeed + (grav * dt)
    if self.y > HEIGHT then 
        self.y = love.math.random(100) - 200
        self.yspeed = self:map(self.z, 0, 20, 4, 10)
    end
end

function Drop:draw()
    love.graphics.setColor(self:colorValue(), self:colorValue(), self:colorValue())
    local thick = math.floor( self:map(self.z, 0, 20, 1, 3) )
    love.graphics.rectangle("fill", self.x, self.y, thick, self.len + thick)
    love.graphics.setColor(1, 1, 1)
end

function Drop:map(value, fromLow, fromHigh, toLow, toHigh)
    -- Check if the value is outside of the input range
    if (value < fromLow or value > fromHigh) then
        print("Value is outside of the input range")
        return 0.0 -- Return a default value or handle the error appropriately
    end

    -- Perform linear interpolation to map the value to the output range
    return toLow + (value - fromLow) * ((toHigh - toLow) / (fromHigh - fromLow))
end

function Drop:colorValue() 
    return (255.0 - (self.z * 20.0)) / 255
end


return Drop