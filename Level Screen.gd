extends Control

onready var tilemap = $nums/TileMap
onready var nums = $nums
onready var label = $nums/Label
onready var everything = $nums/everything
onready var level_Finished = $LevelFinished
onready var answer = $LevelFinished/Answer
onready var hLine = $nums/hLine
onready var vLine = $nums/vLine

var img
var SCALE
var PREVIOUS_CELL = {}
var PREVIOUS_STATE
var STOPPER = true
var PREVIOUS_HOVER_CELL = {}
const PIXEL = 16
var SCALING = {
	"10": 0.9,
	"15": 0.65,
	"20": 0.6
}


func load_image():
	img = load(Levels.select_puzzle(Game.selected_puzzle)).get_data()


func ready_level():
	img.lock()
	Game.not_finished = true
	Game.length = img.get_width()
	Game.tilemap = tilemap
	Game.everything = everything
	Game.finish = level_Finished
	Game.answer = answer
	Game.ready_Game(img, everything, label)
	var vLines = img.get_width() / 5 - 1
	var hLines = img.get_height() / 5 - 1
	var vPos = (img.get_width() * 48) / (vLines + 1)
	var vPos_y = Game.longest_horizontal * 48
	var vPos_statis = vPos
	var hPos = (img.get_height() * 48 ) / (hLines + 1)
	var hPos_x = Game.longest_vertical * 48
	var hPos_statis = vPos
	for _i in range(vLines):
		var new_V_Line = vLine.duplicate()
		new_V_Line.visible = true
		new_V_Line.set_size(Vector2(4, img.get_height() * 48))
		new_V_Line.set_position(Vector2(vPos - 2 + (Game.longest_vertical * 48),vPos_y))
		everything.add_child(new_V_Line)
		vPos += vPos_statis
	for _i in range(hLines):
		var new_H_Line = hLine.duplicate()
		new_H_Line.visible = true
		new_H_Line.set_size(Vector2(img.get_width() * 48, 4))
		new_H_Line.set_position(Vector2(hPos_x,hPos + (Game.longest_horizontal * 48) - 2))
		everything.add_child(new_H_Line)
		hPos += hPos_statis
	nums.rect_scale.x = SCALING[str(img.get_width())]
	nums.rect_scale.y = SCALING[str(img.get_width())]


func _input(event):
	if event is InputEventMouseMotion and Game.not_finished:
		img.lock()
		SCALE = tilemap.scale.x * SCALING[str(img.get_width())]
		var x = floor(event.position[0] / (PIXEL * SCALE))
		var y = floor(event.position[1] / (PIXEL * SCALE))
		var state = tilemap.get_cell(x,y)
		if (not PREVIOUS_HOVER_CELL.get("x") == x or not PREVIOUS_HOVER_CELL.get("y") == y) and (state == 0 or state == 1 or state == 2):
			Game.hover_nums(x, y, PREVIOUS_HOVER_CELL)
			PREVIOUS_HOVER_CELL["x"] = x
			PREVIOUS_HOVER_CELL["y"] = y
		elif not state == 0 and not state == 1 and not state == 2:
			Game.clear_hover_nums(PREVIOUS_HOVER_CELL.get("x"), PREVIOUS_HOVER_CELL.get("y"))
			PREVIOUS_HOVER_CELL.clear()
	if (Input.is_action_pressed("left_click") or Input.is_action_pressed("right_click")) and Game.not_finished:
		img.lock()
		SCALE = tilemap.scale.x * SCALING[str(img.get_width())]
		var x = floor(event.position[0] / (PIXEL * SCALE))
		var y = floor(event.position[1] / (PIXEL * SCALE))
		var state = tilemap.get_cell(x,y)
		if STOPPER:
			STOPPER = false
			PREVIOUS_STATE = state
		if (not PREVIOUS_CELL.get("x") == x or not PREVIOUS_CELL.get("y") == y) and PREVIOUS_STATE == state:
			Game.decide_Action(x, y)
			PREVIOUS_CELL["x"] = x
			PREVIOUS_CELL["y"] = y
	if (Input.is_action_just_released("left_click") or Input.is_action_just_released("right_click")):
		STOPPER = true
		PREVIOUS_CELL.clear()

