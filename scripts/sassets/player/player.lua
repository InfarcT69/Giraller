player = {}
local lg = love.graphics
function player:init(x, y, world, cam)
	lg.setDefaultFilter('nearest', 'nearest')
	self.cam = cam
	self.x = x
	self.y = y
    self.neackx, self.neacky = 0, 0
    self.headx, self.heady = 0, 0
    self.topy = self.y + 100
    self.topx = self.x + 30
   	self.angle = 0

    self.neck2 = world:newRectangleCollider(self.x, self.y, 60, 150)
    self.neck2:setCollisionClass('NeckG')
    self.offSetX = 20
    self.neck = world:newRectangleCollider(self.x, self.y + 150, 60, 150)
    self.neck:setCollisionClass('NeckG')
    self.neckCollider = world:newRectangleCollider(self.x, self.y - 30, 60, 60)
    self.neckCollider:setCollisionClass('Neck')
    self.neck:setType('static')
    self.nsprite = lg.newImage('assets/player/pNeck.png')
    self.bnsprite = lg.newImage('assets/player/pBNeck.png')
    self.hspriteR = lg.newImage('assets/player/pHeadR.png')
    self.hspriteL = lg.newImage('assets/player/pHeadL.png')
    self.hsprite = self.hspriteR
    self.fsprite = lg.newImage('assets/player/filleck.png')
    self.csprite = lg.newImage('assets/player/cloud.png')
	self.angularDamping = 25000 
    self.joint = world:addJoint('RevoluteJoint', self.neck, self.neck2, self.x + 30, self.y + 150, false)
    self.joint1 = world:addJoint('RevoluteJoint', self.neck2, self.neckCollider, self.x + 30, self.y, true)
    self.touchArea = nil
    self.isReady = false
end



function player:update(dt)
    local tx, ty = love.mouse.getPosition()
    local ftx, fty = cam:worldCoords(tx, ty)
    local zeroX, zeroY = cam:worldCoords(0, 0)
    local screenWX, screenHY = cam:worldCoords(lg.getWidth(), lg.getHeight())
    self.neckx, self.necky = self.neck:getPosition()
    self.headx, self.heady = self.neck2:getPosition()
    self.angle = self.neck2:getAngle()
    local vx, vy = self.neck2:getLinearVelocity()
    local angularVelocity = self.neck2:getAngularVelocity()

    if self.headx < self.topx then
        self.offSetX = 20
        self.hsprite = self.hspriteL
    elseif self.headx > self.topx then
        self.offSetX = 16
        self.hsprite = self.hspriteR
	end
    if self.isReady == true then
	    if ftx < (screenWX + zeroX) / 2 then
	    	self.touchArea = 'left'
	    elseif ftx > (screenWX + zeroX) / 2 then
	    	self.touchArea = 'right'

	    end


	    if touch('left') and self.heady < self.topy and angularVelocity > -0.8 then
	    	if self.heady < self.topy then
	       		self.neck2:applyAngularImpulse(-3000)
	       	end
	    elseif touch('right') and self.heady < self.topy and angularVelocity < 0.8 then
	    	if self.heady < self.topy then

		        self.neck2:applyAngularImpulse(3000)
		    end
	    else

	        local dampingImpulse = -angularVelocity * self.angularDamping

	        self.neck2:applyAngularImpulse(dampingImpulse)
	    end
	    if self.heady > self.topy and self.headx > self.topx then

	    	self.neck2:applyAngularImpulse(-5000)
	    end
	    if self.heady > self.topy and self.headx < self.topx then

	    	self.neck2:applyAngularImpulse(5000)
	    end
	end

end
function touch(dir)

	local r = nil
	if love.mouse.isDown(1) and dir == player.touchArea then

		r = true
	else
		r = false
	end
	return r
end

function player:draw()

    lg.draw(self.fsprite, self.neckx - 30, self.necky - 100, 0, 3, 3)
    lg.draw(self.bnsprite, self.neckx - 30, self.necky - 75, 0, 3, 3)
    lg.draw(self.hsprite, self.headx , self.heady, self.angle, 3, 3, self.offSetX, 45 )
    lg.draw(self.nsprite, self.neckx - 30, self.necky - 75, 0, 3, 3)
    lg.draw(self.csprite, self.neckx - 123, self.necky + 10, 0, 3, 3)

end

