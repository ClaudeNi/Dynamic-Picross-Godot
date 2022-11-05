extends Node

const default_data = {
			"beaten_levels": [],
			"bg_volume": 1,
			"se_volume": 1
		}
		
const keybinds = {
	"Left_Click": [16777221, null],
	"Right_Click": [16777237 , null],
	"Move_Up": [16777232 , 87],
	"Move_Right": [16777233 , 68],
	"Move_Down": [16777234 , 83],
	"Move_Left": [16777231 , 65],
}

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = default_data
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	
	check_and_correct_file()
	
	Levels.beaten_levels = game_data["beaten_levels"]
	Levels.update_images()

func delete_data():
	var dir = Directory.new()
	dir.remove("user://save_file.save")
	load_data()

func check_and_correct_file():
	for key in default_data.keys():
		if not game_data.has(key):
			game_data[key] = default_data[key]
	save_data()
