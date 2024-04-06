Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'

WIDTH = 800
HEIGHT = 640

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    local room_files = {}
    recursiveEnumerate('rooms', room_files)
    requireFiles(room_files)

    Font = love.graphics.newFont('assets/Juniory.ttf', 32) 
    love.graphics.setFont(Font)

    input = Input()
    input:bind('1', '1')
    input:bind('2', '2')
    input:bind('backspace', 'backspace')
    input:bind('escape', 'escape')
    input:bind('mouse1', 'leftButton')
    love.window.setMode(WIDTH, HEIGHT)
    love.window.setTitle("Love falling graphical effect")

    current_room = nil
    gotoRoom('Menu')
end

function love.update(dt)
    if current_room then current_room:update(dt) end

    if input:released('escape') then 
        love.event.quit()
    elseif input:released('backspace') then
        gotoRoom('Menu')
    end
end

function love.draw()
    if current_room then current_room:draw() end
end

-- Room --
function gotoRoom(room_type, ...)
    current_room = _G[room_type](...)
end

-- Load --
function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        print("File ",file)
        require(file)
    end
end


function love.run()
    if love.math then love.math.setRandomSeed(os.time()) end
    if love.load then love.load(arg) end
    if love.timer then love.timer.step() end

    local dt = 0
    local fixed_dt = 1/30
    local accumulator = 0

    while true do
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == 'quit' then
                    if not love.quit or not love.quit() then
                        return a
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end

        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        accumulator = accumulator + dt
        while accumulator >= fixed_dt do
            if love.update then love.update(fixed_dt) end
            accumulator = accumulator - fixed_dt
        end

        if love.graphics and love.graphics.isActive() then
            love.graphics.clear(love.graphics.getBackgroundColor())
            love.graphics.origin()
            if love.draw then love.draw() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end
