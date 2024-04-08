FallingSand = Object:extend()


function FallingSand:new()
    self.size = 5
    self.grid = {}
    self.nextGrid = {}
    self.clicked = false
    self.hueValue = 0
    self.cols = math.floor(WIDTH / self.size)
    self.rows = math.floor(HEIGHT / self.size)
    for i = 1, self.cols do
        self.grid[i]     = {}
        self.nextGrid[i] = {}
        for j = 1, self.rows do 
            self.grid[i][j] = 0
            self.nextGrid[i][j] = 0
        end
    end
end

function FallingSand:update(dt)
    local mouseX, mouseY
    local mouseCol =  1
    local mouseRow = 1
    local matrix = 5
    local extent = math.floor(matrix / 2)
    if input:down('leftButton') then
        mouseX, mouseY = love.mouse.getPosition()
        mouseCol = math.floor(mouseX / self.size)
        mouseRow = math.floor(mouseY / self.size)
        for i = -extent, extent do
            for j = -extent, extent do
                local randomValue = love.math.random(100)
                if randomValue < 75 then
                    local col = mouseCol + i + 1
                    local row = mouseRow + j + 1
                    if self:withinCols(col) and self:withinRows(row) then
                        self.grid[col][row] = self.hueValue 
                    end
                end
            end
        end

        self.hueValue = self.hueValue + 2;
        if self.hueValue > 255 then
            self.hueValue = 1
        end
    end

    for i = 1, self.cols do
        for j = 1, self.rows do 
            self.nextGrid[i][j] = 0
        end
    end

    for i = 1, self.cols do
        for j = 1, self.rows do
            --  What is the state?
            local state = self.grid[i][j]
            -- Randomly fall left or right
            if state > 0 then 
                local below = self.grid[i][j + 1]
                -- Randomly fall left or right
                local dir = 1
                if love.math.random(100) < 50 then 
                    dir = dir * -1
                end

                --Check below left or right
                local belowA = -1
                local belowB = -1
                if self:withinCols(i + dir) then 
                    belowA = self.grid[i + dir][j + 1]
                end
                if self:withinCols(i - dir) then 
                    belowB = self.grid[i - dir][j + 1]
                end
                -- Can it fall below or left or right?
                if below == 0 then 
                    self.nextGrid[i][j + 1] = state
                elseif belowA == 0 then 
                    self.nextGrid[i + dir][j + 1] = state
                elseif belowB == 0 then
                    self.nextGrid[i - dir][j + 1] = state;
                    -- Stay put!
                else 
                    self.nextGrid[i][j] = state;
                end
            end
        end
    end

    for i = 1, self.cols do
        for j = 1, self.rows do
            if self.grid[i][j] ~= self.nextGrid[i][j] then
                self.grid[i][j] = self.nextGrid[i][j]
            end
        end
    end
end

function FallingSand:draw()
    local font = love.graphics.getFont()
    local fontWidth = font:getWidth("Falling Sand")
    local fontHeight = font:getHeight()
    love.graphics.print("Falling Sand", WIDTH / 2, 50, 0, 1, 1, fontWidth / 2, fontHeight / 2)
    for i = 1, self.cols do 
        for j = 1, self.rows do 
            if self.grid[i][j] > 0 then 
                love.graphics.setColor(self.grid[i][j] / 255, 1.0, 1.0)
                local x = (i - 1) * self.size
                local y = (j - 1) * self.size
                love.graphics.rectangle('fill', x, y, self.size, self.size)
            end
        end
    end
    love.graphics.setColor(1.0, 1.0, 1.0)
end

function FallingSand:withinCols(x)
    return x >= 1 and x <= self.cols
end

function FallingSand:withinRows(y)
    return y >= 1 and y <= self.rows
end

