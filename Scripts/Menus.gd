extends Control

onready var anim = $AnimationPlayer
onready var camera = $Camera2D
onready var circle = $Circle

func _ready():
	anim.play("fade in")
	Game.camera = camera
	Game.circle = circle
	for btn in get_tree().get_nodes_in_group("Level_Btn"):
		btn.connect("pressed", self, "select_level", [btn])

func quit_game():
	get_tree().quit()	

func select_level(btn):
	Game.selected_puzzle = btn.PUZZLE_NAME
	anim.play("Select Level")

func reset_level():
	Game.reset_level()

func realign_level():
	Game.realign_level()

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


func _on_LevelBack_pressed():
	anim.play("Return from Level")
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	Levels.update_images()


#func _on_Button_pressed():
#	var new_lvl = lvl.duplicate()
#	new_lvl.get_children()[3].text = "test"
#	new_lvl.set_position(Vector2(0,0))
#	new_lvl.get_children()[2].connect("pressed", self, "pr")
#	lvls.add_child(new_lvl)
#func pr():
#	print("test")
