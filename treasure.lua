treasure = {}  -- This define the treasure object
local tframes = {}
--local tactiveFrame = 0
--local tcurrentFrame = 1
local telapsedTime = 0
local captured = false

function treasureLoad()
	treasure.x = (love.graphics.getWidth() / 2) + 90
	treasure.y = (love.graphics.getHeight() / 2 ) + 10
	timageFile = love.graphics.newImage("gfx/treasure.png", love.image_optimize)

	tframes[1] = love.graphics.newQuad(0,0,21,21, timageFile:getDimensions())
	tframes[2] = love.graphics.newQuad(21,0,21,21, timageFile:getDimensions())

	treasure.currentFrame = 1
	treasure.activeFrame = 0
	treasure.activeFrame = tframes[treasure.currentFrame]

	captured = false
end

function getTreasure()
	if not captured then
		sfxTreasure = love.audio.newSource("audio/price.mp3", "static")
		sfxTreasure:setVolume(1)
		sfxTreasure:play()
		captured = true
	end
	
end


function treasureUpdate(dt)
	if not captured then
		--UPDATE TIME
    	telapsedTime = telapsedTime + dt
	end
end


function drawTreasure()
	if not captured then
		if(telapsedTime > 0.3) then

			if(treasure.currentFrame < 2 and treasure.currentFrame >= 1) then
				treasure.currentFrame = treasure.currentFrame + 1
			else
				treasure.currentFrame = 1
			end

			treasure.activeFrame = tframes[treasure.currentFrame]
			telapsedTime = 0
		end

		love.graphics.draw(timageFile, --texture
			treasure.activeFrame, --quad
	        treasure.x,  --x
	        treasure.y,  --y
	        0, --r orientation in radians
	        1,
	        1)
	end
end