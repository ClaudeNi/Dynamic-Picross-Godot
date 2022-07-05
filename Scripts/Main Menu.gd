extends Control

onready var fade_control = $Fade

func _ready():
	if Save.first_time_loading:
		Save.load_data()
		if not Save.game_data["music_muted"]:
			AudioPlayer.play_BG_track(AudioPlayer.puzzle_bg)
	else:
		fade_control.visible = false
