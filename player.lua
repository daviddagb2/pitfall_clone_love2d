-- Config for player movements
-- Variables
player = {}  -- This define the player object

imageFile  = nil
frames = {}

activeFrame = 0
currentFrame = 1
direction = 2 -- 1:lef, 2:right, 3:jump, 4:climb, 5:idle

local playerSpeed = 0.1 -- de 0 a 1
local playerAnimSpeed = 340 --speed original 500
local mirrowed = 1
local collition = false
local isdead = false

function playerLoad()

	sfxjump = love.audio.newSource("audio/jump.mp3", "static")
	sfxjump:setVolume(1)

	sfxdeath = love.audio.newSource("audio/death.mp3", "static")
	sfxdeath:setVolume(1)

	-- DEBUG TEXT
	love.graphics.setNewFont(12)

	player.width = 21
	player.height = 21

	-- PLAYER VARIABLES
	-- This is the coordinates where the player character will be rendered.
	player.x = love.graphics.getWidth() / 2   -- This sets the player at the middle of the screen based on the width of the game window. 
	player.y = (love.graphics.getHeight() / 2 ) + 30  -- This sets the player at the middle of the screen based on the height of the game window. 
	player.speed = 110    -- This is the player's speed. This value can be change based on your liking.
	player.ismoving = false --saber si el player se esta moviendo

	-- This calls the file named "purple.png" and puts it in the variable called player.img.
	player.img = love.graphics.newImage('gfx/player/idle.png')
	player.ground = player.y     -- This makes the character land on the plaform.

	player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
	player.jump_height = -130    -- Whenever the character jumps, he can reach this height.
	player.gravity = -500        -- Whenever the character falls, he will descend at this rate.


	imageFile = love.graphics.newImage("gfx/player/spritesheetplayer.png", love.image_optimize)

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


function playerUpdate(dt)
	if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
			direction = 1
			player.ismoving = true
		else
			direction = 5
			player.ismoving = false
		end
		mirrowed = 1
	elseif love.keyboard.isDown('a') then
		if player.x > player.img:getWidth() then 
			player.x = player.x - (player.speed * dt)
			direction = 2
			player.ismoving = true
		else
			direction = 5
			player.ismoving = false
		end
		mirrowed = -1
	else
		player.ismoving = false
	end
 
	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
			sfxjump:play()
		end
	end
 
	--if player.x_v
	if not player.ismoving then 
		direction = 5
	end

	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end
 
	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
    	direction = 5
	end


	if CheckCollision(player.x, player.y, player.width, player.height, 
					  treasure.x, treasure.y, 21, 21) then
		collition = true
		getTreasure()
	end

end



function drawPlayer()
	-- PLAYER DRAW
	-- This draws the player.
	--love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
	if collition then
		--love.graphics.print("Colisiono con el tesoro", 25, 50)
	else

	end

	if not isdead then 
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

		elseif (direction == 3) then

		elseif (direction == 4) then

		elseif (direction == 5) then
			currentFrame = 1
		end

		activeFrame = frames[currentFrame]
		elapsedTime = 0
	end
	
		--love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
		love.graphics.draw(imageFile, --texture
			activeFrame, --quad
	        player.x,  --x
	        player.y,  --y
	        0, --rotation 
	        mirrowed, --mirrowed
	         1.5, 0, 21)

		if player.ismoving then
			--love.graphics.print("player.ismoving." , 0, 10)
		else
			--love.graphics.print("player stoped." , 0, 10)
		end

	end --is not dead

		
end



