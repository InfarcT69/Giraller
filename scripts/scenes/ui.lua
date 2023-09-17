ui = {}
local lg = love.graphics
local tb = require 'libraries/touchbuttons'
function ui:load(playX, playY)
	self.play = {}
	self.play.x = playX
	self.play.y = playY

	self.play.button = tb:newRectangleButton(self.play.x, self.play.y, 165, 165, 'mouse')
	self.play.icon = lg.newImage('assets/menu/playB.png')
	self.play.isPlayed = false
	self.alphaTransition = 1
end

function ui:update(dt)
	if self.play.isPlayed == false then
		if self.play.button:checkPressedAR(1) then
			self.play.isPlayed = true
			self.play.button.Returned = false
		end
	else
		if self.alphaTransition > 0 then
			self.alphaTransition = self.alphaTransition - 2 * dt
		end
	end

end

function ui:draw()
	lg.setColor(255, 255, 255, self.alphaTransition)
	lg.draw(self.play.icon, self.play.x, self.play.y)

	lg.setColor(255, 255, 255, 1)
end