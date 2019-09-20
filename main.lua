
require "player"

platform = {}
player = {}  -- Add this below the platform variable 
-- Variables
score = 0
minutes = 20
seconds = 0
elapsedTime = 0
gKeyPressed = {}

function love.load()
    -- PLATFORM VARIABLES
    -- This is the height and the width of the platform.
	platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
	platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.
 
        -- This is the coordinates where the platform will be rendered.
	platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
	platform.y = platform.height / 2             -- This starts drawing the platform at the very middle of the game window


	-- PLAYER VARIABLES
	-- This is the coordinates where the player character will be rendered.
	player.x = love.graphics.getWidth() / 2   -- This sets the player at the middle of the screen based on the width of the game window. 
	player.y = love.graphics.getHeight() / 2  -- This sets the player at the middle of the screen based on the height of the game window. 
	player.speed = 200    -- This is the player's speed. This value can be change based on your liking.

	-- This calls the file named "purple.png" and puts it in the variable called player.img.
	player.img = love.graphics.newImage('gfx/player/idle.png')
	player.ground = player.y     -- This makes the character land on the plaform.

	player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
	player.jump_height = -300    -- Whenever the character jumps, he can reach this height.
	player.gravity = -500        -- Whenever the character falls, he will descend at this rate.

	--PLAYER ANIMATION
	---animation = newAnimation(love.graphics.newImage("gfx/player/spritesheetplayer.png"), 21, 21, 1)	
	playerLoad() -- from player.lua

end


function love.update(dt)

	if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then 
			player.x = player.x - (player.speed * dt)
		end
	end
 
	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end
 
	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end
 
	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
	end

	--ANIMATION UPDATE
	--animation.currentTime = animation.currentTime + dt
    --if animation.currentTime >= animation.duration then
    --    animation.currentTime = animation.currentTime - animation.duration
    --end


    --UPDATE CONTROLLERS
    elapsedTime = elapsedTime + dt

    if (gKeyPressed.left) then 
		pressLeft(dt)
	end

	if (gKeyPressed.right) then 
		pressRight(dt)
	end

end

 
function love.draw()

	-- Set Background Color to #731b87 (115, 27, 135) with an alpha of 50%
    -- Note: Remember that Love uses 0-1 and not 0-255
	red = 190/255
    green = 178/255
    blue = 48/255
    alpha = 50/100

	-- PLATFORM DRAW
	love.graphics.setColor(red, green, blue)     -- This sets the platform color to yellow.
 
        -- The platform will now be drawn as a yellow rectangle while taking in the variables we declared above.
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)

	-- PLAYER DRAW
	-- This draws the player.
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)


	-- ANIMATION DRAW
	--local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    --love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], 0, 0, 0, 4)
    drawPlayer()

	-- SCORE DRAW
	love.graphics.setColor(1, 1, 1)
    love.graphics.print("SCORE." .. score , 10, 30)

end


function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end





function love.keyreleased( key )
	gKeyPressed[key] = nil
end


function love.keypressed( key, unicode ) 
	gKeyPressed[key] = true 
	if (key == "escape") then os.exit(0) end
	
end



--CONTROLLERS EVENTS
function pressLeft(dt)
	local s = playerAnimSpeed *dt
	
	--if(gCamX > 240) then
	--	gCamX = gCamX - s
	--end 
	
	playerPressLeft()
end


function pressRight(dt)
	local s = playerAnimSpeed *dt
	
	--if(gCamX < 785) then
	--	gCamX = gCamX + s 
	--end
	
	
	playerPressRight()
end
