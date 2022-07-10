extends Control

onready var anim = $Control/AnimationPlayer
onready var lvls = $"Screens/Level Select Screen/LevelsScrollContainer/Levels"
onready var lvl = $"Screens/Level Select Screen/LevelsScrollContainer/Levels/Level 1"

func _ready():
	if Save.first_time_loading:
		anim.play("fade in")
		Save.first_time_loading = false
	elif not Save.coming_back_from_level:
		anim.play("RESET")
	if Save.coming_back_from_level:
		anim.play("RESET on Level Selection")
		Save.coming_back_from_level = false
	for btn in get_tree().get_nodes_in_group("Level_Btn"):
		btn.connect("pressed", self, "select_level", [btn])


func quit_game():
	get_tree().quit()	


func select_level(btn):
	Game.selected_puzzle = btn.PUZZLE_NAME
	anim.play("Select Level")


func return_from_level():
	anim.play("Level Screen Fade In")


func _on_StartBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu1)
	anim.play("Start to Levels")


func _on_OptionsBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu1)
	anim.play("Start to Options")


func _on_QuitBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	anim.play("Quit Game")


func _on_LevelsGoBackBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	anim.play("Levels to Start")


func _on_OptionsGoBackBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	
	anim.play("Options to Start")


#func _on_Button_pressed():
#	var new_lvl = lvl.duplicate()
#	new_lvl.get_children()[3].text = "test"
#	new_lvl.set_position(Vector2(0,0))
#	new_lvl.get_children()[2].connect("pressed", self, "pr")
#	lvls.add_child(new_lvl)
#func pr():
#	print("test")
