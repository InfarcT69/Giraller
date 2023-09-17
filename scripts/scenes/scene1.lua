Scene = {}

local wf = require 'libraries/windfield'
local world
local lg = love.graphics


function Scene:load()

    require 'scripts/collClasses'
    require 'scripts/scenes/ui'
    camera = require 'libraries/camera'
    cam = camera()
    require 'scripts/sassets/player/player'
	lg.setDefaultFilter('nearest', 'nearest')
  	world = wf.newWorld(0, 0)
    chargeClasses(world)
    player:init(400, 200, world, cam)
    zeroX, zeroY = cam:worldCoords(0, 0)

    screenWX, screenHY = cam:worldCoords(lg.getWidth(), lg.getHeight())

    backgroundSky = lg.newImage('assets/background/1.png')
    ui:load(screenWX - 200, screenHY - 200)
    bgSkyY = (screenHY - zeroY) - (backgroundSky:getHeight() * getScale(backgroundSky))

 
end

function getScale(selectedBackground)
    local background = selectedBackground
    local screenAspectRatio = lg.getWidth() / lg.getHeight()
    local bgAspectRatio = background:getWidth() / background:getHeight()

    local scale = 1
    if screenAspectRatio > bgAspectRatio then
        scale = lg.getWidth() / background:getWidth()
        
    else
        
        scale = lg.getHeight() / background:getHeight()
    end

    return scale
end

function Scene:update(dt)

    world:update(dt)
    ui:update(dt)
    if ui.play.isPlayed then
        player.isReady = true
    end
    player:update(dt)


    cam:lookAt(player.x + 30, (player.y - lg.getHeight() + 300) + lg.getHeight() / 2)
end



function Scene:draw()

    lg.draw(backgroundSky, 0, bgSkyY, 0, getScale(backgroundSky), getScale(backgroundSky))
    
    ui:draw()
    cam:attach()
        player:draw()
        --world:draw()
    cam:detach()
end


return Scene