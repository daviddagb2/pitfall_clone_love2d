require "functions"
require "player"
require "treasure"
require "hole"
require "background"

platform = {}

-- Variables
score = 2000
local minutes = 1
local seconds = 59
local lives = 2
local livesstr = "||"
local timeractive = true


elapsedTime = 0
gKeyPressed = {}

--First you define the counter.
counter = 0
counterLimit = 1

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
	backgroundLoad()

	--LOAD TREASURE
	treasureLoad()

	--LOAD HOLE TRAP
	holeLoad()

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

	-- UPDATE COLLECTIBLES
	treasureUpdate(dt)

	-- UPDATE TRAPS
	holeUpdate(dt)


	if timeractive then
		--In your update, you use something like this:
		counter = counter + dt
		if counter >= counterLimit then
		  --DO YOUR THING
		  --seconds = seconds -1
		end

		seconds = seconds -dt
		if seconds <= 0 then
			minutes = minutes -1
			seconds = 59
		end

		if minutes <= 0 then
			timeractive = false 
			minutes = 20
		end
	end
	

end

 
function love.draw()

	--SET green color to BG
    funcSetBackgroundColor(0, 158, 71, 100)


    love.graphics.setBlendMode("alpha", "alphamultiply")

    --BACKGROUND DRAW	 
	drawBackground()

	drawHole()

	-- TREASURE DRAW
    drawTreasure()


	setBlendTransparent()
	-- ANIMATION DRAW
    drawPlayer()

  
    setBlendNormal()
    
  


	-- SCORE DRAW
	love.graphics.setFont(Font)
    love.graphics.printf(" " .. score, 5, 10, 100,"right") -- align right to x = 100 + 200 = 300
    love.graphics.print(livesstr .. "   " .. minutes .. " : " ..  math.floor(seconds) , 5, 30)

    --love.graphics.print("debug var", 5, 50)   


end




function love.keyreleased( key )
	gKeyPressed[key] = nil
end


function love.keypressed( key, unicode ) 
	gKeyPressed[key] = true 
	if (key == "escape") then os.exit(0) end

	if (key == "g") then timeractive = false end
	if (key == "h") then timeractive = true end
	
end

