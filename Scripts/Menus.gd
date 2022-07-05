extends Control

onready var anim = $AnimationPlayer

func _ready():
	if Save.first_time_loading:
		anim.play("fade in")
		Save.first_time_loading = false
	if Save.coming_back_from_level:
		anim.play("RESET on Level Selection")
		Save.coming_back_from_level = false


func quit_game():
	get_tree().quit()	


func _on_StartBtn_pressed():
	anim.play("Start to Levels")


func _on_OptionsBtn_pressed():
	anim.play("Start to Options")


func _on_QuitBtn_pressed():
	anim.play("Quit Game")


func _on_LevelsGoBackBtn_pressed():
	anim.play("Levels to Start")


func _on_OptionsGoBackBtn_pressed():
	anim.play("Options to Start")
	pass # Replace with function body.
