extends Node2D

onready var img = load(Levels.select_puzzle(Game.selected_puzzle)).get_data()

onready var tilemap = $TileMap
onready var nums = $nums
onready var label = $nums/Label
onready var level_Finished = $LevelFinished
onready var answer = $LevelFinished/Answer

var SCALE
var PREVIOUS_CELL = {}
var PREVIOUS_STATE
var STOPPER = true
const PIXEL = 16

func _ready():
	img.lock()
	Game.ready_Game(img, tilemap, nums, label)
	if img.get_width() > 10:
		tilemap.scale.x = 2.2
		tilemap.scale.y = 2.2
		nums.rect_scale.x = 0.74
		nums.rect_scale.y = 0.74

func _input(event):
	if (Input.is_action_pressed("left_click") or Input.is_action_pressed("right_click")):
		SCALE = tilemap.scale.x
		var x = floor(event.position[0] / (PIXEL * SCALE))
		var y = floor(event.position[1] / (PIXEL * SCALE))
		var state = tilemap.get_cell(x,y)
		if STOPPER:
			STOPPER = false
			PREVIOUS_STATE = state
		if (not PREVIOUS_CELL.get("x") == x or not PREVIOUS_CELL.get("y") == y) and PREVIOUS_STATE == state:
			Game.decide_Action(x, y, tilemap, level_Finished, answer)
			PREVIOUS_CELL["x"] = x
			PREVIOUS_CELL["y"] = y
	if (Input.is_action_just_released("left_click") or Input.is_action_just_released("right_click")):
		STOPPER = true
		PREVIOUS_CELL.clear()
	#print(Game.vertical_nums)
	#print(Game.horizontal_nums)
