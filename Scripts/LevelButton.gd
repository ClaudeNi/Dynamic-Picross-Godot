extends Button


func _on_Button_pressed():
	Game.reset_level()
	get_tree().change_scene("res://nodes/Level Selection Screen.tscn")
