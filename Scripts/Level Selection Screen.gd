extends Node2D


func _on_Button2_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu2)
	get_tree().change_scene("res://nodes/Main Menu.tscn")
