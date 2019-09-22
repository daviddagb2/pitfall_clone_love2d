	-- Set Background Color to #731b87 (115, 27, 135) with an alpha of 50%
    -- Note: Remember that Love uses 0-1 and not 0-255
	--red = 255/255
    --green = 27/255
    --blue = 135/255
    --alpha = 50/100

function funcSetColor(r, g, b, a)
	return love.graphics.setColor(raw2color(r, g, b, a))
end

function funcSetBackgroundColor(r, g, b, a)
	love.graphics.setBackgroundColor(raw2color(r, g, b, a))
end


function raw2color(r, g, b, a)
	if type(r) == 'table' then
		r, g, b, a = unpack(r)
	end

	return r / 255, g / 255, b / 255, a and a / 255
end


function setBlendNormal()
love.graphics.setBlendMode("alpha", "alphamultiply")
end

function setBlendTransparent()
love.graphics.setBlendMode('multiply', 'premultiplied')
end

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end