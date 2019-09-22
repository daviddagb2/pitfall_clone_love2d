
holetrap = {}  -- This define the hole object
local holeframes = {}
local helapsedTime = 0
local captured = false
local hole_active = true

function holeLoad()
	
	holetrap.x = (love.graphics.getWidth() / 2) 
	holetrap.y = (love.graphics.getHeight() / 2 )
	himageFile = love.graphics.newImage("gfx/enviroment/hole.png", love.image_optimize)

	holeframes[1] = love.graphics.newQuad(0,0,200,20, himageFile:getDimensions())
	holeframes[2] = love.graphics.newQuad(0,20,200,20, himageFile:getDimensions())
	holeframes[3] = love.graphics.newQuad(0,40,200,20, himageFile:getDimensions())
	holeframes[4] = love.graphics.newQuad(0,60,200,20, himageFile:getDimensions())

	holetrap.currentFrame = 1
	holetrap.activeFrame = 0
	holetrap.activeFrame = holeframes[holetrap.currentFrame]

	hole_active = false
end


function holeUpdate(dt)

	if hole_active then
		--if hole is active player can down
		helapsedTime = helapsedTime + dt
	end
end


function drawHole()
	if hole_active then 

		if(helapsedTime > 0.3) then

			if(holetrap.currentFrame < 4 and holetrap.currentFrame >= 1) then
				holetrap.currentFrame = holetrap.currentFrame + 1
			else
				holetrap.currentFrame = 1
			end

			holetrap.activeFrame = holeframes[holetrap.currentFrame]
			helapsedTime = 0
		end

		love.graphics.draw(himageFile, --texture
			holetrap.activeFrame, --quad
	        holetrap.x,  --x
	        holetrap.y,  --y
	        0, --r orientation in radians
	        1,
	        1)
	end

end