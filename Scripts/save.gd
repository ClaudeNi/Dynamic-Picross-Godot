extends Node

const SAVE_FILE = "user://save_file.save"
var game_data = {}

var first_time_loading = true

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"beaten_levels": [],
			"music_muted": false
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	
	Levels.beaten_levels = game_data["beaten_levels"]
