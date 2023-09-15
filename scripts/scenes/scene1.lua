Scene = {}
-- Importa la librería Windfield
-- Carga Windfield y crea un mundo
local wf = require 'libraries/windfield'
local world
local lg = love.graphics
function Scene:load()
	lg.setDefaultFilter('nearest', 'nearest')
  	world = wf.newWorld(0, 0)
  	giraffe = {}
    -- Crea el cuerpo principal de la jirafa

    neackx, neacky = 0, 0
    headx, heady = 0, 0

   	giraffe.angle = 0
    -- Crea el cuello de la jirafa
    giraffe.neck2 = world:newRectangleCollider(400, 200, 20, 50)

    giraffe.neck = world:newRectangleCollider(400, 250, 20, 50)
    giraffe.neck:setType('static')
    giraffe.nsprite = lg.newImage('assets/player/pNeck.png')
    giraffe.hsprite = lg.newImage('assets/player/pHead.png')
    giraffe.fsprite = lg.newImage('assets/player/filleck.png')
    -- Crea un joint revoluto entre el cuello y el cuerpo
    --giraffe.joint = world:addJoint('RevoluteJoint', giraffe.body, giraffe.neck, 410, 200, true)
    giraffe.joint2 = world:addJoint('RevoluteJoint', giraffe.neck, giraffe.neck2, 410, 250, false)
end
local angularDamping = 2500 -- Ajusta este valor según sea necesario

function Scene:update(dt)
    -- Actualiza el mundo Windfield
    world:update(dt)
    
    neckx, necky = giraffe.neck:getPosition()
    headx, heady = giraffe.neck2:getPosition()
    giraffe.angle = giraffe.neck2:getAngle()
    local angularVelocity = giraffe.neck2:getAngularVelocity()
    print(heady)
    -- Maneja la entrada para mover el cuello
    if love.keyboard.isDown('left') and heady < 230 then
    	if heady < 230 then 
       		--giraffe.neck:applyAngularImpulse(100)
       		giraffe.neck2:applyAngularImpulse(-100)
       	end
    elseif love.keyboard.isDown('right') and heady < 230 then
    	if heady < 230 then
	        --giraffe.neck:applyAngularImpulse(-100)
	        giraffe.neck2:applyAngularImpulse(100)
	    end
    else
        -- Aplica un amortiguamiento angular para que el cuello regrese gradualmente a la posición original
        local dampingImpulse = -angularVelocity * angularDamping
        --giraffe.neck:applyAngularImpulse(dampingImpulse)
        giraffe.neck2:applyAngularImpulse(dampingImpulse)
    end
    if heady > 230 and headx > 410 then
    	--giraffe.neck:applyAngularImpulse(500)
    	giraffe.neck2:applyAngularImpulse(-500)
    end
    if heady > 230 and headx < 410 then
    	--giraffe.neck:applyAngularImpulse(-500)
    	giraffe.neck2:applyAngularImpulse(500)
    end
end


function Scene:draw()
    -- Dibuja el péndulo
    --local x1, y1, x2, y2 = world:getJointAnchors(joint)
    --love.graphics.line(x1, y1, x2, y2)
    lg.draw(giraffe.fsprite, neckx - 10, necky - 31, 0, 1, 1)
    lg.draw(giraffe.hsprite, headx , heady, giraffe.angle, 1, 1, 16, 45)
    lg.draw(giraffe.nsprite, neckx - 10, necky - 25, 0, 1, 1)
    
    --world:draw()
    --local px, py = pendulum:getPosition()
    --ove.graphics.circle('fill', px, py, 10)
end


return Scene