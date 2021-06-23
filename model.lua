local model = {}

view = require "view"

function model.init()
	board = {}
	board_height = 15
	board_width = 4
	math.randomseed(os.time())
	local function is_corner(r, c)
		return 	(r == 1  and c == 1) or (r ==  1 and c == 3) or
		(r == 2  and c == 1) or (r ==  2 and c == 4) or
		(r == 14 and c == 1) or (r == 14 and c == 4) or
		(r == 15 and c == 1) or (r == 15 and c == 3)
	end

	for r = 1, board_height do
		board[r] = {}
		d = r%2
		for c = 1, (board_width-d) do
			if not is_corner(r, c) then
				i = math.random(1, 6)
				board[r][c] = i
				view.draw(r, c, i)
			end
		end
	end
	picked_i = 0
	picked_r = 0
	picked_c = 0
end

function model.pick(r, c)
	if not picked then
		picked = true
		picked_i = board[r][c]
		view.clear(r, c)
		view.follow(r, c, picked_i)
		picked_r = r
		picked_c = c
		print("picking up "..tostring(r).." "..tostring(c))
	elseif (not (picked_r == r)) or (not (picked_c == c)) then
		print("row"..r)
		print("board[r]"..r)
		if not (board[r] == nil or board[r][c] == nil) then
			print("swap")
			view.clear(r, c)
			print("yeah I cleared it")
			view.draw(picked_r, picked_c, board[r][c])
			board[picked_r][picked_c] = board[r][c]
			picked_r = r
			picked_c = c
		end
	end
end

function model.drop(r, c)
	picked = false
	view.draw(r, c, picked_i)
	picked_i = 0
	print("in model.drop calling view.draw("..tostring(r)..", "..tostring(c)..")")
	view.drop()
end

return model
