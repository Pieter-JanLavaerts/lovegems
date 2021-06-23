local view = {}

follow_i = 0
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

function view.clear(r, c)
	table.insert(updates, {r, c, 1})
end

function view.draw(r, c, i)
	print("draw("..r..", "..c..")")
	table.insert(updates, {r, c, i+1})
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

function love.draw()
	if updates then
		for i, u in ipairs(updates) do
			draw_gem(u[1], u[2], u[3])
		end
	end
	updates = {}

	if not ((follow_i == 0) or (follow_i == nil)) then
		x, y = love.mouse.getPosition()
		--love.graphics.draw(images[follow_i], x-u, y-u, 0, scale, scale)
		follow_x = x
		follow_y = y
	end
end

return view
