
require "player"

platform = {}

-- Variables
local score = 2000
local minutes = 20
local seconds = 0
local lives = 2
local livesstr = "||"
elapsedTime = 0
gKeyPressed = {}


function love.load()
    -- PLATFORM VARIABLES
    -- This is the height and the width of the platform.
	platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
	platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.
 
        -- This is the coordinates where the platform will be rendered.
	platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
	platform.y = platform.height / 2              -- This starts drawing the platform at the very middle of the game window

	--PLAYER ANIMATION
	playerLoad() -- from player.lua

	--LOAD ATARI FONT
	Font = love.graphics.newFont("fonts/AtariST8x16SystemFont.ttf", 18)

	--LOAD BACKGROUND
	bgquad = love.graphics.newQuad(0,0,400,400,384,320)
	bgImage = love.graphics.newImage('gfx/bg/background.png')
	bgImage:setWrap('repeat','repeat')

end


function love.update(dt)

	--ANIMATION UPDATE
    playerUpdate(dt)

    --UPDATE CONTROLLERS
    elapsedTime = elapsedTime + dt

    --LIVES
    livesstr = ""
    for i = 1, lives do
	  livesstr = livesstr .. "|"
	end

end

 
function love.draw()

	-- Set Background Color to #731b87 (115, 27, 135) with an alpha of 50%
    -- Note: Remember that Love uses 0-1 and not 0-255
	red = 255/255
    green = 27/255
    blue = 135/255
    alpha = 50/100
    love.graphics.setBackgroundColor( red, green, blue, alpha)

    love.graphics.setBlendMode("alpha", "alphamultiply")

    --BACKGROUND DRAW	 
    love.graphics.draw(bgImage,bgquad,0,0)	

	love.graphics.setBlendMode('multiply', 'premultiplied')
	-- ANIMATION DRAW
    drawPlayer()

    love.graphics.setBlendMode("alpha", "alphamultiply")

	-- SCORE DRAW
	love.graphics.setFont(Font)
	--love.graphics.setColor(1, 1, 1)
    love.graphics.printf(" " .. score, 5, 10, 100,"right") -- align right to x = 100 + 200 = 300

    love.graphics.print(livesstr .. "   " .. minutes .. " : " ..  seconds, 5, 30)


end




function love.keyreleased( key )
	gKeyPressed[key] = nil
end


function love.keypressed( key, unicode ) 
	gKeyPressed[key] = true 
	if (key == "escape") then os.exit(0) end
	
end

