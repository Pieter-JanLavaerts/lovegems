local view = {}

follow_i = 0
board = {}
function view.init(w, h, b)
	window_width = w
	window_height = h
	window_border = b

	images = {}
	images[1] = love.graphics.newImage("assets/clear_gem.png")
	images[2] = love.graphics.newImage("assets/blue_gem.png")
	images[3] = love.graphics.newImage("assets/green_gem.png")
	images[4] = love.graphics.newImage("assets/purple_gem.png")
	images[5] = love.graphics.newImage("assets/yellow_gem.png")
	images[6] = love.graphics.newImage("assets/red_gem.png")
	images[7] = love.graphics.newImage("assets/health_gem.png")

	canvas_width = window_width - (2 * window_border)
	u = canvas_width/13 -- u = unit, radius of gem
	gem_width = 2*u
	scale = gem_width/images[1]:getWidth()

	updates = {}

end

local function draw_gem(r, c, i)
	if i == 0 then
		return
	end

	d = r % 2
	x = window_border + d*1.5*u + c*u + (c-1)*gem_width
	y = window_height - ((18 - r) * u) + window_border
	love.graphics.draw(
		images[i],
		x, y,
		0,
		scale, scale
	)
end

function view.follow(y, x, i)
	print("view.follow called")
	follow_y = y
	follow_x = x
	follow_i = i+1
end

function view.drop()
	print("view.drop called")
	follow_i = 0
end

board_width = 4
board_height = 15
function view.draw(b)
	board = b
end
function love.draw()
	if (board == nil) then
		return
	end
	for r, board_width in ipairs(board) do
		for c, board_width in ipairs(board) do
			if not (board[r][c] == nil) then
				draw_gem(r, c, board[r][c]+1)
			end
		end
	end

	if not ((follow_i == 0) or (follow_i == nil)) then
		x, y = love.mouse.getPosition()
		love.graphics.draw(images[follow_i], x-u, y-u, 0, scale, scale)
		follow_x = x
		follow_y = y
	end
end

return view
