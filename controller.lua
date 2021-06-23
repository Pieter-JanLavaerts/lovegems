local controller = {}

model = require "model"

function controller.mousemoved(x, y, dx, dy, istouch)
	c = col(x, y)
	r = row(x, y)
	if picked then
		model.pick(r, c)
	end
end

function controller.mousepressed(x, y, button, istouch, presses)
	c = col(x, y)
	r = row(x, y)
	model.pick(r, c)
	picked = true
end

function controller.mousereleased(x, y, button, istouch, presses)
	c = col(x, y)
	r = row(x, y)
	print("model.drop("..tostring(r)..", "..tostring(c)..")")
	model.drop(r, c)
end

function controller.init(w, h, b)
	window_width = w
	window_height = h
	window_border = b
	canvas_width = window_width - (2 * window_border)
	u = canvas_width/13 -- u = unit, radius of gem
	love.mousemoved = controller.mousemoved
	love.mousepressed = controller.mousepressed
	love.mousereleased = controller.mousereleased
	model.init()
end

function x_units(x)
	return ((x - window_border + u) / u) - 1
end

function y_units(y)
	return ((window_height - ((window_height - y) - window_border)) / u) - 9
end

function col(w_x, w_y)
	x = x_units(w_x)
	y = y_units(w_y)
	return math.floor((x+2)/3)
end

function row(w_x, w_y)
	x = x_units(w_x)
	y = y_units(w_y)
	if (math.floor(x % 3) == 0) then
		return math.floor(y - ((y+1)%2))
	end
	return math.floor(y-(y%2))
end

return controller
