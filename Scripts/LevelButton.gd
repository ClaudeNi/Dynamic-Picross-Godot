extends Button


func _on_Button_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu2)
	Game.reset_level()
	get_tree().change_scene("res://nodes/Level Selection Screen.tscn")
