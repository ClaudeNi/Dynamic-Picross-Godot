extends Control

onready var anim = $AnimationPlayer
onready var fade_control = $Fade

func _ready():
	if Save.first_time_loading:
		anim.play("fade in")
		Save.load_data()
		Save.first_time_loading = false
		AudioPlayer.play_BG_track(AudioPlayer.puzzle_bg)
	else:
		fade_control.visible = false

func _on_Button_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu1)
	get_tree().change_scene("res://nodes/Level Selection Screen.tscn")


func _on_Button2_pressed():
	AudioPlayer.play_SF_track(AudioPlayer.menu2)
	get_tree().quit()


func _on_Button3_pressed():
	pass # Replace with function body.
