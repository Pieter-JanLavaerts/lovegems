view = require "view"
controller = require "controller"


function love.load()
	window_height = 750
	window_ratio = 9/16
	window_width = window_height * window_ratio
	window_border = window_width/20

	love.window.setMode(window_width, window_height)

	view.init(window_width, window_height, window_border)
	controller.init(window_width, window_height, window_border)
end
