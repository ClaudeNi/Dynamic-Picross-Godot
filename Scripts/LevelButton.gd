extends Button


func _on_Button_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	Game.reset_level()
	Save.coming_back_from_level = true
	get_tree().change_scene("res://nodes/Menus.tscn")
