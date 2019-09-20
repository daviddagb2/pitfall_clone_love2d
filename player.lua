-- Config for player movements
-- Variables
imageFile  = nil
frames = {}

activeFrame = 0
currentFrame = 1
direction = 2 -- 1:lef, 2:right, 3:jump, 4:climb, 5:idle

playerSpeed = 0.5 -- de 0 a 1
playerAnimSpeed = 100 --speed original 500


local playerWidth = 21
local playerHeight = 21


playerPosX = 2
playerPosY = 2

function playerLoad()

	imageFile = love.graphics.newImage("gfx/player/spritesheetplayer.png")

    --Sprites idle
    frames[1] = love.graphics.newQuad(0,0,21,21,imageFile:getDimensions())

    --Sprites right
	frames[2] = love.graphics.newQuad(21,0,21,21,imageFile:getDimensions())
	frames[3] = love.graphics.newQuad(42,0,21,21,imageFile:getDimensions())
	frames[4] = love.graphics.newQuad(63,0,21,21,imageFile:getDimensions())
	frames[5] = love.graphics.newQuad(84,0,21,21,imageFile:getDimensions())
	frames[6] = love.graphics.newQuad(105,0,21,21,imageFile:getDimensions())

	--Sprites climb
	frames[7] = love.graphics.newQuad(126,0,21,21,imageFile:getDimensions())
	frames[8] = love.graphics.newQuad(147,0,21,21,imageFile:getDimensions())

	--Sprites jump
	frames[9] = love.graphics.newQuad(168,0,21,21,imageFile:getDimensions())
	frames[10] = love.graphics.newQuad(189,0,21,21,imageFile:getDimensions())

	--Sprites vine
	frames[11] = love.graphics.newQuad(210,0,21,21,imageFile:getDimensions())


	activeFrame = frames[currentFrame]
    print(select(4,activeFrame:getViewport())/2)

end



function playerPressLeft()
	direction = 1 -- 1:lef, 2:right, 3:jump, 4:climb, 5:idle
	if not (direction == 1) then
		currentFrame = 2
	end
	
	playerPosX = playerPosX - playerSpeed
	if(playerPosX <= 0) then
		playerPosX = 0
	end
	
end


function playerPressRight()
	direction = 2 -- 1:lef, 2:right, 3:jump, 4:climb, 5:idle
	if not (direction == 2) then
		currentFrame = 2
	end
	
	playerPosX = playerPosX + playerSpeed
	if(playerPosX >= love.graphics.getWidth() - playerWidth) then
		playerPosX = love.graphics.getWidth() - playerWidth
	end
	
end



function drawPlayer()
	if(elapsedTime > 0.3) then

		if (direction == 1) then
			--Move frames left
			--..............................
			--Move character sprites 
			if(currentFrame < 6 and currentFrame >= 2) then
				currentFrame = currentFrame + 1
			else
				currentFrame = 2
			end
			--..............................

		elseif (direction == 2) then
			--Move frames left
			--..............................
			--Move character sprites 
			if(currentFrame < 6 and currentFrame >= 2) then
				currentFrame = currentFrame + 1
			else
				currentFrame = 2
			end
			--..............................
		end

		activeFrame = frames[currentFrame]
		elapsedTime = 0
	end
	
	love.graphics.draw(imageFile, --texture
		activeFrame, --quad
        playerPosX,  --x
        playerPosY,  --y
        0, --r orientation in radians
        1,
        1)
end



