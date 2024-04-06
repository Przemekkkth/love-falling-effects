Menu = Object:extend()

function Menu:new()

end

function Menu:update(dt)
    if input:released('1') then 
        gotoRoom('FallingRain')
    elseif input:released('2') then
        gotoRoom('FallingSand') 
    end
end

function Menu:draw()
    local font = love.graphics.getFont()
    local fontWidth = font:getWidth("Menu")
    local fontHeight = font:getHeight()
    -- love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )
    love.graphics.print("Menu", WIDTH / 2, 50, 0, 1, 1, fontWidth / 2, fontHeight / 2)
    fontWidth = font:getWidth("1. Falling Rain")
    love.graphics.print("1. Falling Rain", WIDTH / 2, HEIGHT / 2, 0, 1, 1, fontWidth / 2, fontHeight / 2)
    fontWidth = font:getWidth("2. Falling Sand")
    love.graphics.print("2. Falling Sand", WIDTH / 2, HEIGHT / 2 + 50, 0, 1, 1, fontWidth / 2, fontHeight / 2)
end