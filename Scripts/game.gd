extends Node

var selected_puzzle = ""

var vertical_nums = []
var horizontal_nums = []
var black_cells = []
var white_cells = []
var selected_cells = []

var longest_vertical = 0
var longest_horizontal = 0

func ready_Game(img, tilemap, nums, label):
	var WIDTH = img.get_width()
	var HEIGHT = img.get_height()
	
	ready_nums(img, WIDTH, HEIGHT)
	place_nums(tilemap, nums, label)
	ready_cells(img, WIDTH, HEIGHT, tilemap)

func ready_nums(img, WIDTH, HEIGHT):
	for i in range(WIDTH):
		var h_nums_line = []
		var h_num = 0
		var v_nums_line = []
		var v_num = 0
		for j in range(HEIGHT):
			var H_COLOR = img.get_pixel(i,j)
			if H_COLOR == Color(0,0,0,1):
				h_num += 1
			if H_COLOR == Color(1,1,1,1) and not h_num == 0:
				h_nums_line.append(h_num)
				h_num = 0
			
			var V_COLOR = img.get_pixel(j,i)
			if V_COLOR == Color(0,0,0,1):
				v_num += 1
			if V_COLOR == Color(1,1,1,1) and not v_num == 0:
				v_nums_line.append(v_num)
				v_num = 0
		if not h_num == 0:
			h_nums_line.append(h_num)
		if not v_num == 0:
			v_nums_line.append(v_num)
		h_nums_line.invert()
		v_nums_line.invert()
		horizontal_nums.append(h_nums_line)
		vertical_nums.append(v_nums_line)

func place_nums(tilemap, nums, label):
	for i in vertical_nums:
		if i.size() > longest_vertical:
			longest_vertical = i.size()
	for i in horizontal_nums:
		if i.size() > longest_horizontal:
			longest_horizontal = i.size()
	
	for i in range(vertical_nums.size()):
		for j in range(vertical_nums[i].size()):
			tilemap.set_cell(longest_vertical - j - 1,longest_horizontal + i,3)
			var new_Label = label.duplicate()
			new_Label.visible = true
			new_Label.text = str(vertical_nums[i][j])
			new_Label.set_position(Vector2((longest_vertical - j - 1) * 48,(longest_horizontal + i) * 48))
			nums.add_child(new_Label)

	for i in range(horizontal_nums.size()):
		for j in range(horizontal_nums[i].size()):
			tilemap.set_cell( longest_vertical + i,longest_horizontal - j - 1, 3)
			var new_Label = label.duplicate()
			new_Label.visible = true
			new_Label.text = str(horizontal_nums[i][j])
			new_Label.set_position(Vector2(((longest_vertical + i) * 48),(longest_horizontal - j - 1) * 48))
			nums.add_child(new_Label)
	

func ready_cells(img, WIDTH, HEIGHT, tilemap):
	for i in range(WIDTH):
		for j in range(HEIGHT):
			var COLOR = img.get_pixel(i,j)
			var new_x = i + longest_vertical
			var new_y = j + longest_horizontal
			tilemap.set_cell(new_x,new_y,0)
			if COLOR == Color(1,1,1,1):
				Game.white_cells.append(str(new_x) + "," + str(new_y))
			if COLOR == Color(0,0,0,1):
				Game.black_cells.append(str(new_x) + "," + str(new_y))

func decide_Action(x, y, tilemap):
	var state = tilemap.get_cell(x,y) # 0 = EMPTY / 1 = FULL / 2 = CROSSED
	if not state == 0 and not state == -1 and not state == 3:
		tilemap.set_cell(x,y,0)
		state = 0
	elif Input.is_action_pressed("left_click") and not state == -1 and not state == 3:
		tilemap.set_cell(x,y,1)
		state = 1
	elif Input.is_action_pressed("right_click") and not state == -1 and not state == 3:
		tilemap.set_cell(x,y,2)
		state = 2
	check_cell(str(x),str(y), state)

func check_cell(x, y, state):
	var ind2 = selected_cells.find(x + "," + y)
	if not ind2 == -1:
		selected_cells.pop_at(ind2)
	elif state == 1:
		selected_cells.append(x + "," + y)
	if compare_arrays():
		print("done")

func compare_arrays():
	for cell in black_cells:
		if not selected_cells.has(cell):
			return false
	for cell in white_cells:
		if selected_cells.has(cell):
			return false
	return true 
