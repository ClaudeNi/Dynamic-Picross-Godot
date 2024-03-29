extends Node

var selected_puzzle = ""
var not_finished = false
var tilemap
var everything
var finish
var answer
var length
var last_x
var last_y
var anim_cell
var scaling

var vertical_nums = []
var horizontal_nums = []
var black_cells = []
var white_cells = []
var selected_cells = []

var longest_vertical = 0
var longest_horizontal = 0

func ready_Game(img, nums, label):
	
	var WIDTH = img.get_width()
	var HEIGHT = img.get_height()
	
	ready_nums(img, WIDTH, HEIGHT)
	place_nums(nums, label)
	ready_cells(img, WIDTH, HEIGHT)

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
		if h_nums_line.size() == 0:
			h_nums_line.append(0)
		if v_nums_line.size() == 0:
			v_nums_line.append(0)
		h_nums_line.invert()
		v_nums_line.invert()
		horizontal_nums.append(h_nums_line)
		vertical_nums.append(v_nums_line)

func place_nums(nums, label):
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
	

func ready_cells(img, WIDTH, HEIGHT):
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

func decide_Action(x, y):
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
		clear_hover_nums(last_x, last_y)
		reveal_answer()
		#show_victory()

func compare_arrays():
	for cell in black_cells:
		if not selected_cells.has(cell):
			return false
	for cell in white_cells:
		if selected_cells.has(cell):
			return false
	return true 
	
func reset_level():
	vertical_nums = []
	horizontal_nums = []
	black_cells = []
	white_cells = []
	selected_cells = []
	longest_vertical = 0
	longest_horizontal = 0
	finish.visible = false
	not_finished = false
	answer.text = ""
	tilemap.clear()
	for child in everything.get_children():
		child.queue_free()

func realign_level():
	Globals.camera.offset.x = 0
	Globals.back_btn.rect_position.x = 1178
	Globals.circle.rect_position.x = 0

func hover_nums(x, y, previous):
	var prev_x = previous.get("x")
	var prev_y = previous.get("y")
	clear_hover_nums(prev_x, prev_y)
	for i in range(longest_vertical):
		var state = tilemap.get_cell(i,y)
		if state == 3:
			tilemap.set_cell(i,y,4)
	for j in range(longest_horizontal):
		var state = tilemap.get_cell(x,j)
		if state == 3:
			tilemap.set_cell(x,j,4)

func clear_hover_nums(x, y):
	if not y == null:
		for i in range(longest_vertical):
			var state = tilemap.get_cell(i,y)
			if state == 4:
				tilemap.set_cell(i,y,3)
	if not x == null:
		for j in range(longest_horizontal):
			var state = tilemap.get_cell(x,j)
			if state == 4:
				tilemap.set_cell(x,j,3)

func show_victory():
	for k in range(length * 2):
		for j in range(k + 1):
			var i = k - j
			var x = i + longest_vertical
			var y = j + longest_horizontal
			if i < length and j < length:
				if tilemap.get_cell(x,y) == 2:
					tilemap.set_cell(x,y,0)
				elif tilemap.get_cell(x,y) == 1:
					var new_cell = anim_cell.duplicate()
					tilemap.set_cell(x,y,1)
					new_cell.set_position(Vector2(x * 64 * scaling,y * 64 * scaling))
					new_cell.visible = true
					new_cell.play()
					everything.add_child(new_cell)
		yield(get_tree().create_timer(0.3),"timeout")
	reveal_answer()

func reveal_answer():
	realign_level()
	answer.text = "It was " + selected_puzzle.to_upper()
	finish.visible = true
	not_finished = false
	Levels.beaten_levels.append(selected_puzzle)
	Save.game_data["beaten_levels"] = Levels.beaten_levels
	Save.save_data()

#func zoom_in():
	#Globals.zoom_X -= Globals.zoom
	#Globals.zoom_Y -= Globals.zoom
	#Globals.camera.zoom = Vector2(Globals.zoom_X, Globals.zoom_Y)
	#Globals.camera.offset.x = Globals.camera.offset.x - (Globals.camera.offset.x * Globals.zoom)
	
	
#func zoom_out():
	#if Globals.zoom_X < 1:
		#Globals.zoom_X += Globals.zoom
		#Globals.zoom_Y += Globals.zoom
		#Globals.camera.zoom = Vector2(Globals.zoom_X, Globals.zoom_Y)
