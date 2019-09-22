local bgamount = 4

function backgroundLoad()
	bgquad = love.graphics.newQuad(0,0,400,400,384,320)
	randomNumber = love.math.random(1, bgamount)
	bgImage1 = love.graphics.newImage('gfx/bg/bg' .. randomNumber .. '.png')
	bgImage1:setWrap('repeat','repeat')
end


function backgroundUpdate(dt)

end


function drawBackground()
	love.graphics.draw(bgImage1,bgquad,0,0)
end