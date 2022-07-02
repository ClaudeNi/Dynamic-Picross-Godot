extends Control

onready var btn1 = $Button

func _ready():
	Save.load_data()
	AudioPlayer.play_BG_track(AudioPlayer.puzzle_bg)

func _on_Button_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu1)
	get_tree().change_scene("res://nodes/Level Selection Screen.tscn")


func _on_Button2_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu2)
	get_tree().quit()
