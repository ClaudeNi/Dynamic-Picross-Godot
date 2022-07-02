extends Node2D

onready var check_box = $Options/CheckBox

func _ready():
	if Save.game_data["music_muted"]:
		check_box.pressed = true


func _on_Button2_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu1)
	get_tree().change_scene("res://nodes/Main Menu.tscn")


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		AudioPlayer.audioBG.stop()
		Save.game_data["music_muted"] = true
	else:
		AudioPlayer.play_BG_track(AudioPlayer.puzzle_bg)
		Save.game_data["music_muted"] = false
	Save.save_data()
