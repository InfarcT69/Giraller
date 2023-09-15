local wf = require 'libraries/windfield'
local lg = love.graphics

function love.load()


	manageScene("scene1")

	--scene1 = juego, scene2 = retry, scene3 = menu
end

function love.update(dt)
	if Scene.update then Scene:update(dt) end

end

function love.draw()
	if Scene.draw then Scene:draw() end

end

function manageScene(SelectedScene)
	Scene = require("scripts/scenes/"..SelectedScene)
	if Scene.load then Scene:load() end
end
